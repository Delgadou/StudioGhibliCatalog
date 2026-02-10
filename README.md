Studio Ghibli Catalog  
Um aplicativo iOS desenvolvido em SwiftUI que exibe o catálogo completo de filmes do Studio Ghibli, fornecendo informações detalhadas sobre cada produção. O app consome a API pública do Studio Ghibli para obter dados atualizados sobre os filmes.    

✨ Funcionalidades    

Catálogo de Filmes:  
- Visualização em grade de dois cards por linha com todos os filmes do Studio Ghibli
- Detalhes do Filme: Tela dedicada com informações completas sobre cada filme
- Design Responsivo: Interface adaptada para diferentes tamanhos de tela
- Estados de Carregamento: Skeletons com efeito shimmer durante o carregamento
- Tratamento de Erros: Tela de erro com opção para tentar novamente
- Otimização de Imagens: Carregamento assíncrono de imagens com placeholders

🏗️ Arquitetura       
O aplicativo segue a arquitetura MVVM (Model-View-ViewModel) com as práticas modernas do Swift 6:
Camadas

- Model: Estruturas de dados (Movie, NetworkError)
- ViewModel: Lógica de negócio e gerenciamento de estado (MoviesCatalogModel)
- View: Interface SwiftUI (MoviesCatalogView, MovieBanner)
- Service: Camada de rede (APIClient)

Concorrência
- Swift 6 Concurrency: Uso de async/await para operações assíncronas
- Main Actor Isolation: @MainActor em ViewModels para garantir thread-safety na UI
- @Observable: Substituição do ObservableObject para gerenciamento de estado reativo

Navegação        
A navegação é baseada em enums por ser:

- Type-safe (sem erros de digitação)
- Testável
- Garante que apenas uma navegação aconteça por vez

Utiliza a biblioteca SwiftUINavigation para suportar navegação via enum em sheets e outros tipos de apresentação que nativamente não aceitam esse padrão.
```
enum Destination {
    case movieDetail(Movie)
    case settings
}
```

Gerenciamento de Estado       
Estados controlados por enums para clareza e segurança:
```
enum State {
    case loading
    case loaded
    case error(Error)
}
```
O que eu faria no aplicativo com mais tempo? Adicionaria novas features ao aplicativo, como aba de filmes assistidos, opção de avaliar o filme, mostrar em qual streaming o filme está disponível para assistir. Além de também refinar a UI e adicionar animações.

Como rodar o aplicativo?
Clonar esse repositório https://github.com/Delgadou/StudioGhibliCatalog e abri-lo no xcode. Após isso selecionar a opção trust & enable dos packages, geralmente ao abrir o xcode a opção de trust & enable aparece no menu da esquerda.
