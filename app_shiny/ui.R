# Carregando pacotes
library(shiny)
library(tidyverse)

# Layout da aplicação
shinyUI(
  fluidPage(
    br(),
    titlePanel("Tendências em Demografia e Renda"),
    p("Explore a diferença entre pessoas que ganham menos de 50 mil e mais de 50 mil. Você pode filtrar os dados por país e depois explorar diversas informações demográficas."),

    # Add o primeiro fluidRow para selecionar a entrada para o país
    fluidRow(
      column(12, wellPanel(selectInput("country", "Selecione o País",
                                       choices = c("United-States",
                                                   "Canada",
                                                   "Mexico",
                                                   "Germany",
                                                   "Philippines")))
      )
    ),

    # Add segundo fluidRow para controlar como plotar as variáveis contínuas
    fluidRow(
      column(3,
             wellPanel(
               p("Selecione uma variável contínua e um tipo de gráfico (histograma ou boxplot) para visualizar à direita."),
               radioButtons("continuous_variable", "Contínua:",
                            choices = c("age", "hours_per_week")), # add botões de opção para variáveis contínuas
               radioButtons("graph_type", "Gráfico:",
                            choices = c("histogram", "boxplot")) # add botões de opção para tipo de gráfico
             )
      ), column(9, plotOutput("p1"))  # add saída do gráfico
    ),

    # Add terceiro fluidRow para controlar como plotar as variáveis categóricas
    fluidRow(
      column(3,
             wellPanel(
               p("Selecione uma variável categórica para visualizar o gráfico de barras à direita. Use a caixa de seleção para visualizar um gráfico de barras empilhadas para combinar os níveis de renda em um gráfico."),
               radioButtons("categorical_variable", "Categoria:",
                            choices = c("education", "workclass", "sex")), # add botões de opção para variáveis categóricas
               checkboxInput("is_stacked", "Barras Empilhadas", value = FALSE) # add entrada da caixa de seleção para opção de gráfico de barras empilhadas
             )
      ), column(9, plotOutput("p2")) # add saída do gráfico
    )
  )
)
