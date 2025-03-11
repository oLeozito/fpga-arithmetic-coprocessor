
#include <iostream>
#include <vector>
using namespace std;

int main(){

    // DECLARACOES
    int tamanho,valor;
    char confirmacao = 'O';
    vector<string> operacao = {"soma","subtracao","multiplicacao","divisao"};
    // DECLARACOES

    while(tolower(confirmacao) != 's'){

        // Iniciar "Matrizes" como vetores.
        cout << "Por favor, digite o tamanho da matriz." << endl;
        cin >> tamanho;
        int matriz1[(tamanho*tamanho)];
        int matriz2[(tamanho*tamanho)];

        if((tamanho >= 2) && (tamanho <= 5)){

            cout << "Por favor, digite valores entre 0-255\n" << endl;

            // Recebe a primeira e segunda matrizes.

            cout << "\nPrimeira Matriz:" << endl;
            for(int i = 0; i<(tamanho*tamanho); i++){
                do{
                    cout << "Digite o " << i+1 << " valor" << endl;
                    cin >> valor;
                }while(valor < 0 || valor > 255);

                matriz1[i] = valor;
            }

            cout << "\nSegunda Matriz:" << endl;
            for(int i = 0; i<(tamanho*tamanho); i++){
                do{
                    cout << "Digite o " << i+1 << " valor" << endl;
                    cin >> valor;
                }while(valor < 0 || valor > 255);
                
                matriz2[i] = valor;
            }
            
            //  Exibir os vetores em forma de matrizes.

            cout << endl;
            int flag = 0; // Flag pra ajudar na formatacao da matriz.
            cout << "\nPrimeira Matriz:" << endl;
            for(int i = 0; i<tamanho*tamanho; i++){
                cout << matriz1[i] << " | ";
                flag++;

                if(flag == tamanho && i != (tamanho*tamanho)-1){
                    cout << "\n-----------------" << endl;
                    flag = 0;
                }
            }

            cout << "\n" <<endl;

            flag = 0;
            cout << "\nSegunda Matriz:" << endl;
            for(int i = 0; i<tamanho*tamanho; i++){
                cout << matriz2[i] << " | ";
                flag++;
                if(flag == tamanho && i != (tamanho*tamanho)-1){
                    cout << "\n-----------------" << endl;
                    flag = 0;
                }
            }

            cout << "\n\nOs valores das matrizes foram corretamente inseridos? s/n " << endl;
            cin >> confirmacao;
        }

        else{cout << "Digite um valor entre 2 e 5!" << endl;}
    }

    // Escolha da operação a ser feita no co-processador.
    int opcao = 0;
    while(!(opcao >= 1 && opcao <= 4)){
        cout << "Qual operacao deseja realizar?\n1-Soma\n2-Subtracao\n3-Multiplicacao\n4-Divisao" << endl;
        cin >> opcao;
    };

    cout << "Enviando matrizes para a FPGA!\n" << "Realizando operacao de "<< operacao[opcao-1] << endl;
    return 0;
}