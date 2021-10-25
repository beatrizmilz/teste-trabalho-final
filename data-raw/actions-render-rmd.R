arquivos <-
  base::list.files(
    pattern = ".Rmd",
    full.names = TRUE,
    recursive = TRUE,
    path = "trabalhos"
  )
usethis::ui_info("Arquivos .Rmd encontrados: {arquivos}")

purrr::map(.x = arquivos, .f = rmarkdown::render,  output_dir = "trabalhos_html")

arquivos_gerados <-
  base::list.files(
    pattern = ".html",
    full.names = TRUE,
    recursive = TRUE,
    path = "trabalhos_html"
  )


usethis::ui_done("Confira os arquivos gerados em:  {nome_arquivo_compilar}")
