library(magrittr)
#?gh::gh()

# Buscas gerais! -----------------------------------------
## buscar actions runs ---------

### quais foram os actions_runs que são de PRs ----
actions_de_prs <- buscar_actions_runs()

### actions para aprovar ----
actions_para_aprovar <- buscar_actions_runs() %>%
  dplyr::filter(conclusion == "action_required")

### aprovar actions -----

aprovar_actions_runs_pendentes()

### checar se tudo foi aprovado ----

buscar_actions_runs() %>%
  dplyr::filter(conclusion == "action_required")


## buscando os PRs abertos / para avaliar  ---------

prs_para_avaliar <- buscar_prs() %>%
  dplyr::filter(state == "open")




# Buscas e tarefas para iterar por PR ------------
##  buscar arquivos em um PR -------

buscar_arquivos_pr(1)

## checklist - o que avaliar? -----

# existe um arquivo .Rmd?
# colocou na pasta certa?

pr_n = 6

arquivos_pr <- buscar_arquivos_pr(pr_n) %>%
  dplyr::select(filename)

arquivos_pr %>%
  dplyr::mutate(pasta_correta = dplyr::case_when(stringr::str_starts(filename, "trabalhos/") ~ TRUE,
                                                 TRUE ~ FALSE),
                rmd = dplyr::case_when(stringr::str_ends(filename, ".Rmd") ~ TRUE,
                                       TRUE ~ FALSE),
                html = dplyr::case_when(stringr::str_ends(filename, ".html") ~ TRUE,
                                       TRUE ~ FALSE),
                )


# .Rmd compilou? / actions passou?

# conseguir identificar o PR, qual coluna pode ser a chave?
prs_para_avaliar %>%
  dplyr::filter(number == pr_n) %>%
  dplyr::left_join(actions_de_prs, by = c("head_user_login" = "head_repository_owner_login")) %>%
  dplyr::glimpse() %>%
  dplyr::select(number, user_login, conclusion)
  View()

names(actions_de_prs)

actions_de_prs$head_repository_owner_login

  prs_para_avaliar %>%
    dplyr::select(tidyselect::starts_with("head_user_login")) %>% View()

actions_de_prs
# nomeou corretamente?

## postar um comentário no PR ----------
# postar a avaliação aqui!

# comentar_pr(1)
