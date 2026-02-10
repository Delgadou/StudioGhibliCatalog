# Studio Ghibli Catalog  
Um aplicativo iOS desenvolvido em SwiftUI que exibe o catálogo completo de filmes do Studio Ghibli, fornecendo informações detalhadas sobre cada produção. O app consome a API pública do Studio Ghibli para obter dados atualizados sobre os filmes.    

## Como compilar e rodar o projeto.
**Requisitos** minimos para compilar o projeto:

* macOS Sequoia 15.0 (ou superior)
* Xcode 16.0 (ou superior)

Após ter os requisitos minimos:
- Clonar o projeto https://github.com/Delgadou/StudioGhibliCatalog
- Abrir o projeto no Xcode.
- Trust & Enable os pacotes do [SwiftNavigation](https://github.com/pointfreeco/swift-navigation).
- Rodar o projeto.

## Funcionalidades    

**Catálogo de Filmes**
- Visualização em grade de dois cards por linha com todos os filmes do Studio Ghibli
- Detalhes do Filme: Tela dedicada com informações completas sobre cada filme
- Design Responsivo: Interface adaptada para diferentes tamanhos de tela
- Estados de Carregamento: Skeletons com efeito shimmer durante o carregamento
- Tratamento de Erros: Tela de erro com opção para tentar novamente
- Otimização de Imagens: Carregamento assíncrono de imagens com placeholders

## Arquitetura       
O aplicativo segue a arquitetura MVVM (Model-View-ViewModel):
- Model: Estruturas de dados (Movie)
- ViewModel: Lógica de negócio e gerenciamento de estado (MoviesCatalogModel)
- View: Interface SwiftUI (MoviesCatalogView, MovieBanner)
- Service: Camada de rede (APIClient, NetworkError)

## Organização de pastas
Eu optei por organizar os arquivos separado por features por questão de simplicidade e fácil entendimento na primeira vez vendo o projeto, isso faz sentido nesse projeto pois é para ser algo pequeno e que não irá escalar no futuro. Com os arquivos no mesmo lugar, isso também reduz a dependencia de outras pastas. 

Arquivos que são usados em mais de um lugar eu optei por criar suas pastas na raiz do projeto (Helpers, Models e Service).

## Navegação        
A navegação é baseada em enums por:

- Garantir que apenas uma navegação aconteça por vez.
- View reage ao valor atual do Enum e navega com segurança ao destino.
- Type-safe (sem erros de digitação).
- Mais fácil de ser testado.

Utiliza a biblioteca [SwiftNavigation](https://github.com/pointfreeco/swift-navigation) para suportar navegação via enum em sheets e outros tipos de apresentação que nativamente não aceitam esse padrão.
```
enum Destination {
    case movieDetail(Movie)
    case settings
}
```

## Gerenciamento de Estado
Estados controlados por enums para clareza e segurança. View reage a mudança de estado, para auxiliar nisso também é usado o @MainActor que faz com que as tarefas sejam executadas na main thread. Ja passei por casos que a view travava ao ser atualizada, a solução era usar o main actor.
```
enum State {
    case loading
    case loaded
    case error(Error)
}
```
### O que eu faria no aplicativo com mais tempo?
* Criar protocolo de NetworkService, que ajudaria na implementação de testes.
* Implementação de testes para o NetworkService e ViewModels.
