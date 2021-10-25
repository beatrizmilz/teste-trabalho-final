buscar_prs <- function(owner = "beatrizmilz",
                       repo = "teste-trabalho-final") {
  list_prs <- gh::gh("/repos/{owner}/{repo}/pulls",
                     owner = owner,
                     repo = repo)

  df_prs <- list_prs %>%
    purrr::map(unlist, recursive = TRUE) %>%
    purrr::map(tibble::enframe) %>%
    purrr::map(tidyr::pivot_wider,
               names_from = name,
               values_from = value) %>%
    purrr::reduce(dplyr::bind_rows) %>%
    janitor::clean_names()


  df_prs
}
