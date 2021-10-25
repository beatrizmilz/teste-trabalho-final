buscar_actions_runs <- function(owner = "beatrizmilz",
                                repo = "teste-trabalho-final") {
  actions <-  gh::gh("/repos/{owner}/{repo}/actions/runs",
                     owner = owner,
                     repo = repo)

  actions %>%
    purrr::pluck("workflow_runs") %>%
    purrr::map(unlist, recursive = TRUE) %>%
    purrr::map(tibble::enframe) %>%
    purrr::map(tidyr::pivot_wider,
               names_from = name,
               values_from = value) %>%
    purrr::reduce(dplyr::bind_rows) %>%
    janitor::clean_names() %>%
    dplyr::select(
      id,
      run_number,
      event,
      conclusion,
      head_repository_full_name,
      head_repository_owner_login
    ) %>%
    dplyr::filter(event == "pull_request")
}
