library(tibble)
library(magrittr)
library(paletteer)
library(stringr)


ggthemes_c_seq_names <- names(ggthemes::ggthemes_data$tableau$sequential)
ggthemes_c_diq_names <- names(ggthemes::ggthemes_data$tableau$diverging)

ggthemes_df <- tibble(
  package = "ggthemes",
  palette = c(ggthemes_c_seq_names, ggthemes_c_diq_names),
  type = c(rep("sequential", length(ggthemes_c_seq_names)),
           rep("diverging", length(ggthemes_c_diq_names)))
  )


pals_df <- tibble(package = "pals",
       palette = names(pals:::syspals)) %>%
  dplyr::filter(!str_detect(palette, "^brewer"),
                !str_detect(palette, "glasbey|kelly|stepped|tol|watlington"),
                !str_detect(palette, "viridis|inferno|magma|plasma|cividis")) %>%
  dplyr::mutate(type = c(rep("diverging", 2), rep("sequential", 19),
                         rep("diverging", 3), rep("sequential", 11),
                         rep("diverging", 5), rep("sequential", 1),
                         rep("diverging", 8), rep("sequential", 28)))

scico_df <- tibble(package = "scico",
                   palette = names(scico:::palettes)) %>%
  dplyr::mutate(type = c(rep("diverging", 1), rep("sequential", 1),
                         rep("diverging", 2), rep("sequential", 5),
                         rep("diverging", 1), rep("sequential", 3),
                         rep("diverging", 1), rep("sequential", 2),
                         rep("diverging", 1)))

other_df <- frame_data(
  ~package, ~palette, ~type,
  "grDevices", "rainbow", "sequential",
  "grDevices", "heat.colors", "sequential",
  "grDevices", "terrain.colors", "sequential",
  "grDevices", "topo.colors", "sequential",
  "grDevices", "cm.colors", "diverging",
  "oompaBase", "redscale", "sequential",
  "oompaBase", "greenscale", "sequential",
  "oompaBase", "bluescale", "sequential",
  "oompaBase", "blueyellow", "diverging",
  "oompaBase", "cyanyellow", "diverging",
  "oompaBase", "redgreen", "diverging",
  "oompaBase", "jetColors", "sequential",
  "oompaBase", "greyscale", "sequential",
  "palr", "bathyDeepPal", "sequential",
  "palr", "chlPal", "sequential",
  "palr", "icePal", "sequential",
  "palr", "sstPal", "sequential",
  "viridis", "viridis", "sequential",
  "viridis", "inferno", "sequential",
  "viridis", "magma", "sequential",
  "viridis", "plasma", "sequential",
  "viridis", "cividis", "sequential"
) %>% as.data.frame()

palettes_c_names <- dplyr::bind_rows(ggthemes_df, pals_df, scico_df, other_df) %>%
  dplyr::arrange(package) %>%
  as.data.frame()

usethis::use_data(palettes_c_names, overwrite = TRUE)
