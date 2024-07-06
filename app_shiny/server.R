# Carregando pacotes
library(shiny)
library(tidyverse)
library(ggthemes)

# Ler dados
adult <- read_csv("./adult.csv")

# Converta os nomes das colunas em letras minúsculas por conveniência
names(adult) <- tolower(names(adult))

# Definir lógica do servidor
shinyServer(function(input, output) {

  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })

  # Criando a lógica para traçar histograma ou boxplot
  output$p1 <- renderPlot({
    if (input$graph_type == "histogram") {
      # Histogram
      ggplot(df_country(), aes_string(x = input$continuous_variable)) +
        geom_histogram(color = "blue", fill = "deepskyblue") +
        labs(y = "Número de Pessoas",
             title = paste("Tendência de", input$continuous_variable)) +
        facet_wrap(~prediction) +
        theme_linedraw()
    }
    else {
      # Boxplot
      ggplot(df_country(), aes_string(y = input$continuous_variable)) +
        geom_boxplot(color = "chocolate", fill = "darkgoldenrod1") +
        coord_flip() +
        labs(x = "Número de Pessoas",
             title = paste("Tendência de", input$continuous_variable)) +
        facet_wrap(~prediction) +
        theme_linedraw()
    }

  })

  # Criando lógica para traçar um gráfico de barras facetado ou um gráfico de barras empilhadas
  output$p2 <- renderPlot({
    # Bar chart
    p <- ggplot(df_country(), aes_string(x = input$categorical_variable)) +
      labs(y = "Número de Pessoas",
           title = paste("Tendência de", input$categorical_variable)) +  # labels
      theme_linedraw() +
      theme(axis.text.x = element_text(angle = 45), legend.position = "bottom") # modifica o tema para alterar o ângulo do texto e a posição da legenda

    if (input$is_stacked) {
      p + geom_bar(aes(fill = prediction))  # adiciona bar geom e usa previsão como preenchimento
    }
    else{
      p +
        geom_bar(aes_string(fill = input$categorical_variable)) + # add bar geom e usa input$categorical_variables como preenchimento
        facet_wrap(~prediction) # faceta por previsão
    }
  })
})
