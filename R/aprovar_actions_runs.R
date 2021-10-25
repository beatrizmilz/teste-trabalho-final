aprovar_actions_runs <- function(run_id,
                                 owner = "beatrizmilz",
                                 repo = "teste-trabalho-final") {
  gh::gh(
    "/repos/{owner}/{repo}/actions/runs/{run_id}/approve",
    owner = owner,
    repo = repo,
    run_id = run_id,
    .method = "POST"
  )
}

aprovar_actions_runs_pendentes <- function(){
  buscar_actions_runs() %>%
    dplyr::filter(conclusion == "action_required") %>%
    dplyr::pull(id) %>%
    purrr::walk(.f = aprovar_actions_runs)
}
