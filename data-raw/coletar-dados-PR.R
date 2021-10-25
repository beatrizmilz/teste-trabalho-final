library(magrittr)
#?gh::gh()

# Buscas gerais! -----------------------------------------
## buscar actions runs ---------

### quais foram os actions_runs que são de PRs ----
buscar_actions_runs()

### actions para aprovar ----
actions_para_aprovar <- buscar_actions_runs() %>%
  dplyr::filter(conclusion == "action_required")

### aprovar actions -----

# FAZER


## buscando os PRs abertos / para avaliar  ---------

prs_para_avaliar <- buscar_prs() %>%
  dplyr::filter(state == "open")


# Buscas e tarefas para iterar por PR ------------
##  buscar arquivos em um PR -------


buscar_arquivos_pr(1)

## checklist - o que avaliar? -----

# existe um arquivo .Rmd?
# colocou na pasta certa?
# .Rmd compilou? / actions passou?
# nomeou corretamente?

## postar um comentário no PR ----------
# postar a avaliação aqui!

# comentar_pr(1)
