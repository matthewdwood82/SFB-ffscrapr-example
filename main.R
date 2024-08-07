# installs ----------------------------------------------------------------

# run if your first pull of the project or if you are getting dependency errors
# renv::restore()


# dependencies ------------------------------------------------------------

# reading
library(ffscrapr)
library(readr)
library(jsonlite)

# munging
library(tibble)
library(purrr)
library(dplyr)
library(tidyr)
library(stringr )

# writing
library(writexl)



# code --------------------------------------------------------------------

# set a vector of players
df_players <- tibble::tibble(sleeper_id = c(
  4034,
  6786,
  3321,
  6794,
  7564,
  9509,
  7547,
  8155,
  5859,
  9493,
  9221,
  8146,
  6813,
  11628,
  4866,
  8150,
  2133,
  8112,
  8144,
  10859,
  6803,
  4984,
  9226,
  7543,
  1466,
  5850,
  3198,
  7569,
  2449,
  2216,
  4983,
  5872,
  8205,
  6819,
  6904,
  7526,
  11632,
  4046,
  4881,
  8136,
  9758,
  4039,
  8130,
  5846,
  7525,
  8138,
  5012,
  10236,
  4018,
  9997,
  9502,
  8151,
  4035,
  8137,
  6801,
  7553,
  1479,
  2309,
  9229,
  4217,
  4199,
  4137,
  4950,
  11620,
  6770,
  5892,
  6790,
  5927,
  4066,
  10229,
  9756,
  7611,
  10222,
  11624,
  4037,
  11604,
  3294,
  5848,
  4981,
  7528,
  5967,
  5849,
  2749,
  8139,
  6804,
  4033,
  8110,
  11635,
  1426,
  7588,
  4988,
  5937,
  11583,
  11631,
  11560,
  4663,
  9488,
  6845,
  8228,
  11637,
  8167,
  8183,
  5022,
  6130,
  5844,
  11589,
  6768,
  5001,
  8148,
  9508,
  3163,
  8154,
  5248,
  11566,
  5045,
  11625,
  8121,
  4082,
  11586,
  3164,
  6797,
  2374,
  9224,
  6826,
  8134,
  7600,
  8143,
  5947,
  7523,
  9753,
  4068,
  11626,
  9481,
  6783,
  1166,
  11643,
  9500,
  7594,
  8676,
  11627,
  421,
  6806,
  9757,
  96,
  6943,
  7021,
  7670,
  8230,
  11596,
  8111,
  11581,
  8119,
  2197,
  6945,
  11638,
  9754,
  11619,
  9486,
  11439,
  8132,
  4381,
  11630,
  8131,
  1689,
  4892,
  4017,
  11647,
  3214,
  11565,
  11655,
  11575,
  7090,
  9501,
  11617,
  9999,
  11640,
  8210,
  10232,
  5133,
  1373,
  11576,
  10235,
  9494,
  8126,
  11564,
  11650,
  7608,
  11600,
  9511,
  7571,
  11584,
  7561,
  4144,
  8129,
  11579,
  7002,
  2078,
  9228,
  11563,
  1234,
  5857,
  2028,
  11645,
  11597,
  6820,
  5987,
  11629,
  5870,
  4080,
  3286,
  9225,
  7591,
  9482,
  4993,
  11618,
  9484,
  6865,
  3225,
  11621,
  8219,
  8172,
  11651,
  11577,
  6011,
  4111,
  5970,
  6828,
  9497,
  4951,
  4454,
  11574,
  5906,
  6149,
  1339,
  7601,
  4943,
  8117,
  4973,
  5995,
  10866,
  9505,
  8225,
  11559,
  7596,
  7567,
  10863,
  11610,
  4171,
  7066,
  6151,
  9492,
  8135,
  7593,
  11570,
  11573,
  10223,
  8162,
  11562,
  11567,
  11592,
  11599,
  10225,
  11616,
  7610,
  11595,
  3257,
  5854,
  6111,
  11652,
  11636,
  11605,
  9998,
  9220,
  11615,
  6886,
  11633,
  11646,
  9227,
  11557,
  10226,
  8142,
  10444,
  11571,
  7562,
  7606,
  2306,
  19,
  11815,
  11748,
  11580,
  11783,
  11568,
  8160,
  10219,
  7538,
  10213,
  8168,
  8159,
  3199,
  7527,
  4089,
  5086,
  6136,
  3271,
  5038,
  6074,
  4147,
  4149,
  4234,
  827,
  7049,
  3634,
  7828,
  8204,
  4029,
  4040,
  8147,
  2560,
  5246,
  1718,
  7703,
  2755
)) %>% 
  dplyr::mutate(
    # develop URL strings
    projection_url = stringr::str_c("https://api.sleeper.com/projections/nfl/player/", sleeper_id, "?season_type=regular&season=2024"),
    player_data = purrr::map(.x = projection_url, ~ jsonlite::fromJSON(.x, flatten = TRUE))) %>% 
  # unnests the player_data lists to columns
  tidyr::unnest_wider(player_data, names_sep = "-") %>%
  # unnests the stats lists inside player_data to columns 
  tidyr::unnest_wider(`player_data-stats`)

readr::write_csv(df_players, file = stringr::str_c("./dat/", stringr::str_replace_all(Sys.Date(), "-", "_"), "_player_projections.csv"))
