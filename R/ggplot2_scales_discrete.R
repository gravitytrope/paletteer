
pal_pal <- function(package, palette, scale, dynamic) {

  if (dynamic) {
    function(n) {
      paletteer_dynamic(package = package, palette = palette, n = n, scale = scale)
    }
  } else {
    function(n) {
      paletteer_d(package = package, palette = palette, scale = scale)
    }
  }
}

#' Discrete scales to use for ggplot2
#'
#' These functions provide the option to use the discrete and dynamic palettes
#' along with the `ggplot2` package. It goes without saying that it requires
#' `ggplot2` to work.
#'
#' @rdname ggplot2-scales-discrete
#' @param ... additional arguments to pass to discrete_scale
#' @param dynamic toggles between the discrete palettes and the dynamic
#'     palettes. Defaults to FALSE which indicates discrete palettes.
#' @inheritParams paletteer_d
#' @importFrom ggplot2 scale_colour_manual
#'
#' @export
#'
#' @importFrom ggplot2 discrete_scale scale_color_gradientn
scale_colour_paletteer_d <- function(package, palette, dynamic = FALSE, ...) {

  package <- rlang::quo_name(rlang::enquo(package))
  palette <- rlang::quo_name(rlang::enquo(palette))

  discrete_scale("colour", paste(package, palette, sep = "-"),
                 pal_pal(package = package, palette = palette, scale = TRUE,
                         dynamic = dynamic), ...)

}

#' @rdname ggplot2-scales-discrete
#' @export
scale_color_paletteer_d <- scale_colour_paletteer_d


#' @rdname ggplot2-scales-discrete
#' @export
#'
scale_fill_paletteer_d <- function(package, palette, dynamic = FALSE, ...) {

  package <- rlang::quo_name(rlang::enquo(package))
  palette <- rlang::quo_name(rlang::enquo(palette))

  discrete_scale("fill", paste(package, palette, sep = "-"),
                 pal_pal(package = package, palette = palette, scale = TRUE,
                         dynamic = dynamic), ...)

}