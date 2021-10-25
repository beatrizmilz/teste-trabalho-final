comentar_pr <- function(pr_n, owner = "beatrizmilz",
                        repo = "teste-trabalho-final") {
  gh::gh(
    "POST /repos/{owner}/{repo}/issues/{number}/comments",
    owner = owner,
    repo = repo,
    number = pr_n,
    body = "Your Message to Comment"
  )
}
