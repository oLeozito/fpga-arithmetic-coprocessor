#include <stdio.h>
#include <ctype.h>

int main() {
    int tamanho, valor;
    char confirmacao = 'O';
    const char *operacao[] = {"soma", "subtracao", "multiplicacao", "divisao"};
    
    while (tolower(confirmacao) != 's') {
        // Solicitar o tamanho da matriz
        printf("Por favor, digite o tamanho da matriz.\n");
        scanf("%d", &tamanho);
        
        if (tamanho >= 2 && tamanho <= 5) {
            int matriz1[tamanho * tamanho];
            int matriz2[tamanho * tamanho];
            
            printf("Por favor, digite valores entre 0-255\n\n");

            // Receber a primeira matriz
            printf("\nPrimeira Matriz:\n");
            for (int i = 0; i < (tamanho * tamanho); i++) {
                do {
                    printf("Digite o %d valor: ", i + 1);
                    scanf("%d", &valor);
                } while (valor < 0 || valor > 255);
                matriz1[i] = valor;
            }

            // Receber a segunda matriz
            printf("\nSegunda Matriz:\n");
            for (int i = 0; i < (tamanho * tamanho); i++) {
                do {
                    printf("Digite o %d valor: ", i + 1);
                    scanf("%d", &valor);
                } while (valor < 0 || valor > 255);
                matriz2[i] = valor;
            }

            // Exibir as matrizes formatadas
            printf("\nPrimeira Matriz:\n");
            int flag = 0;
            for (int i = 0; i < tamanho * tamanho; i++) {
                printf("%d | ", matriz1[i]);
                flag++;
                if (flag == tamanho && i != (tamanho * tamanho) - 1) {
                    printf("\n-----------------\n");
                    flag = 0;
                }
            }
            
            printf("\n\nSegunda Matriz:\n");
            flag = 0;
            for (int i = 0; i < tamanho * tamanho; i++) {
                printf("%d | ", matriz2[i]);
                flag++;
                if (flag == tamanho && i != (tamanho * tamanho) - 1) {
                    printf("\n-----------------\n");
                    flag = 0;
                }
            }
            
            printf("\n\nOs valores das matrizes foram corretamente inseridos? s/n \n");
            scanf(" %c", &confirmacao);
        } else {
            printf("Digite um valor entre 2 e 5!\n");
        }
    }

    // Escolha da operação
    int opcao = 0;
    while (!(opcao >= 1 && opcao <= 4)) {
        printf("Qual operacao deseja realizar?\n1-Soma\n2-Subtracao\n3-Multiplicacao\n4-Divisao\n");
        scanf("%d", &opcao);
    }

    printf("Enviando matrizes para a FPGA!\nRealizando operacao de %s\n", operacao[opcao - 1]);
    return 0;
}