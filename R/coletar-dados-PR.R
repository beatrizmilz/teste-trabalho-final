library(magrittr)
#?gh::gh()

# buscando os PRs abertos

buscar_prs <- function(owner = "beatrizmilz",
                         repo = "teste-trabalho-final") {
  list_prs <- gh::gh("/repos/{owner}/{repo}/pulls",
                     owner = owner,
                     repo = repo)

  df_prs <- list_prs %>%
    purrr:::map(unlist, recursive = TRUE) %>%
    purrr:::map(tibble::enframe) %>%
    purrr:::map(tidyr::pivot_wider,
                names_from = name,
                values_from = value) %>%
    purrr::reduce(dplyr::bind_rows)


  df_prs
}



filtrar_prs_para_avaliar <- function(df){
  df %>%
    dplyr::filter(state == "open")

}




prs_para_avaliar <- buscar_prs() %>% filtrar_prs_para_avaliar()

# -------

buscar_arquivos_pr <- function(pr_n, owner = "beatrizmilz",
         repo = "teste-trabalho-final"){
  gh::gh("/repos/{owner}/{repo}/pulls/{pull_number}/files",
         owner = owner,
         repo = repo,
         pull_number = pr_n) %>%
    purrr:::map(unlist, recursive = TRUE) %>%
    purrr:::map(tibble::enframe) %>%
    purrr:::map(tidyr::pivot_wider, names_from = name, values_from = value) %>%
    purrr::reduce(dplyr::bind_rows)
}

buscar_arquivos_pr(1)




# checklist - o que avaliar?

# existe um arquivo .Rmd?
# colocou na pasta certa?
# .Rmd compilou

# postar um comentário no PR:

comentar_pr <- function(pr_n, owner = "beatrizmilz",
                               repo = "teste-trabalho-final"){
gh::gh("POST /repos/{owner}/{repo}/issues/{number}/comments",
       owner = owner,
       repo = repo,
       number = pr_n,
       body = "Your Message to Comment")
}

comentar_pr(1)
