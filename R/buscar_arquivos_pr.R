buscar_arquivos_pr <- function(pr_n, owner = "beatrizmilz",
                               repo = "teste-trabalho-final") {
  gh::gh(
    "/repos/{owner}/{repo}/pulls/{pull_number}/files",
    owner = owner,
    repo = repo,
    pull_number = pr_n
  ) %>%
    purrr::map(unlist, recursive = TRUE) %>%
    purrr::map(tibble::enframe) %>%
    purrr::map(tidyr::pivot_wider,
               names_from = name,
               values_from = value) %>%
    purrr::reduce(dplyr::bind_rows) %>%
    janitor::clean_names()
}
