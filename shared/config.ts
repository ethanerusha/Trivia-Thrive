// Central season configuration.
// To start a new season: bump CURRENT_SEASON (and SEASON_YEAR if needed),
// then run the season rollover SQL (see migrations/ notes) or create the
// new season's Week 1 in the admin portal.
export const CURRENT_SEASON = 7;
export const SEASON_YEAR = 2026;
export const SEASON_LABEL = `Season ${CURRENT_SEASON}`;
