import { useRef, useState } from "react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useToast } from "@/hooks/use-toast";
import { Image as ImageIcon, Upload, X, Loader2 } from "lucide-react";

const MAX_DIMENSION = 1600;
const JPEG_QUALITY = 0.85;
const MAX_UPLOAD_BYTES = 8 * 1024 * 1024;

function formatBytes(bytes: number): string {
  if (bytes < 1024) return `${bytes} B`;
  if (bytes < 1024 * 1024) return `${Math.round(bytes / 1024)} KB`;
  return `${(bytes / (1024 * 1024)).toFixed(1)} MB`;
}

/**
 * Shrink an image in the browser before uploading so a 5MB phone photo
 * lands as a few hundred KB. Animated GIFs pass through untouched —
 * drawing them to a canvas would flatten them to a single frame.
 */
async function compressImage(file: File): Promise<Blob> {
  if (file.type === "image/gif") return file;

  const objectUrl = URL.createObjectURL(file);
  try {
    const img = await new Promise<HTMLImageElement>((resolve, reject) => {
      const el = new window.Image();
      el.onload = () => resolve(el);
      el.onerror = () => reject(new Error("That file could not be read as an image."));
      el.src = objectUrl;
    });

    const scale = Math.min(1, MAX_DIMENSION / Math.max(img.width, img.height));
    const width = Math.round(img.width * scale);
    const height = Math.round(img.height * scale);

    const canvas = document.createElement("canvas");
    canvas.width = width;
    canvas.height = height;
    const ctx = canvas.getContext("2d");
    if (!ctx) return file;

    // JPEG has no alpha channel, so flatten transparency onto white
    // instead of letting it render as black.
    ctx.fillStyle = "#ffffff";
    ctx.fillRect(0, 0, width, height);
    ctx.drawImage(img, 0, 0, width, height);

    const blob = await new Promise<Blob | null>((resolve) =>
      canvas.toBlob(resolve, "image/jpeg", JPEG_QUALITY)
    );

    // If compressing somehow made it bigger and we never resized, keep the original.
    if (!blob || (blob.size >= file.size && scale === 1)) return file;
    return blob;
  } finally {
    URL.revokeObjectURL(objectUrl);
  }
}

interface ImageFieldProps {
  value: string;
  onChange: (value: string) => void;
  testId?: string;
  label?: string;
}

export function ImageField({ value, onChange, testId, label = "Image (optional)" }: ImageFieldProps) {
  const fileInputRef = useRef<HTMLInputElement>(null);
  const [isUploading, setIsUploading] = useState(false);
  const { toast } = useToast();

  async function handleFile(file: File) {
    if (!file.type.startsWith("image/")) {
      toast({
        title: "Not an image",
        description: "Choose a JPEG, PNG, GIF, or WebP file.",
        variant: "destructive",
      });
      return;
    }

    setIsUploading(true);
    try {
      const blob = await compressImage(file);

      if (blob.size > MAX_UPLOAD_BYTES) {
        toast({
          title: "Image too large",
          description: `That image is ${formatBytes(blob.size)} after compression. The limit is ${formatBytes(MAX_UPLOAD_BYTES)}.`,
          variant: "destructive",
        });
        return;
      }

      const res = await fetch("/api/admin/images", {
        method: "POST",
        headers: {
          "Content-Type": blob.type,
          "X-Filename": encodeURIComponent(file.name),
        },
        body: blob,
        credentials: "include",
      });

      if (!res.ok) {
        const text = (await res.text()) || res.statusText;
        throw new Error(text);
      }

      const { url } = await res.json();
      onChange(url);

      toast({
        title: "Image uploaded",
        description:
          blob.size < file.size
            ? `Optimized from ${formatBytes(file.size)} to ${formatBytes(blob.size)}.`
            : formatBytes(blob.size),
      });
    } catch (error: any) {
      toast({
        title: "Upload failed",
        description: error?.message || "Something went wrong. Please try again.",
        variant: "destructive",
      });
    } finally {
      setIsUploading(false);
      if (fileInputRef.current) fileInputRef.current.value = "";
    }
  }

  return (
    <div className="space-y-2">
      <div className="text-sm text-muted-foreground flex items-center gap-2">
        <ImageIcon className="h-4 w-4" />
        {label}
      </div>

      {value && (
        <div className="relative inline-block">
          <img
            src={value}
            alt="Question preview"
            className="max-h-40 w-auto rounded-lg border object-contain"
          />
          <Button
            type="button"
            variant="destructive"
            size="icon"
            className="absolute -right-2 -top-2 h-6 w-6 rounded-full"
            onClick={() => onChange("")}
            data-testid={testId ? `button-remove-image-${testId}` : undefined}
            aria-label="Remove image"
          >
            <X className="h-3 w-3" />
          </Button>
        </div>
      )}

      <div className="flex flex-col gap-2 sm:flex-row sm:items-center">
        <input
          ref={fileInputRef}
          type="file"
          accept="image/*"
          className="hidden"
          onChange={(e) => {
            const file = e.target.files?.[0];
            if (file) handleFile(file);
          }}
          data-testid={testId ? `input-file-${testId}` : undefined}
        />
        <Button
          type="button"
          variant="outline"
          onClick={() => fileInputRef.current?.click()}
          disabled={isUploading}
          className="sm:w-auto"
          data-testid={testId ? `button-upload-${testId}` : undefined}
        >
          {isUploading ? (
            <Loader2 className="mr-2 h-4 w-4 animate-spin" />
          ) : (
            <Upload className="mr-2 h-4 w-4" />
          )}
          {isUploading ? "Uploading..." : value ? "Replace image" : "Upload image"}
        </Button>

        <span className="text-xs text-muted-foreground sm:px-1">or</span>

        <Input
          value={value}
          onChange={(e) => onChange(e.target.value)}
          placeholder="Paste an image URL"
          disabled={isUploading}
          className="flex-1"
          data-testid={testId ? `input-image-${testId}` : undefined}
        />
      </div>
    </div>
  );
}
