
#include <iostream>
#include <vector>
using namespace std;

int main(){

    // DECLARACOES
    int tamanho;
    char confirmacao = 'O';
    vector<string> operacao = {"soma","subtracao","multiplicacao","divisao"};
    // DECLARACOES

    while(tolower(confirmacao) != 's'){

        // Iniciar Matrizes.
        cout << "Por favor, digite o tamanho da matriz." << endl;
        cin >> tamanho;
        int matriz1[tamanho];
        int matriz2[tamanho];

        if((tamanho >= 2) && (tamanho <= 5)){

            cout << "\nPrimeira Matriz:" << endl;
            for(int i = 0; i<tamanho*tamanho; i++){
                cout << "Digite o " << i+1 << " valor" << endl; 
                cin >> matriz1[i];
            }

            cout << "\nSegunda Matriz:" << endl;
            for(int i = 0; i<tamanho*tamanho; i++){
                cout << "Digite o " << i+1 << " valor" << endl; 
                cin >> matriz2[i];
            }
            
            //  Exibir as matrizes.
            cout << endl;
            int flag = 0;
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

            cout << "\nOs valores das matrizes foram corretamente inseridos? s/n " << endl;
            cin >> confirmacao;
        }

        else{cout << "Digite um valor entre 2 e 5!" << endl;}
    }

    // Escolha da Operação a ser feita
    int opcao = 0;
    while(!(opcao >= 1 && opcao <= 4)){
        cout << "Qual operacao deseja realizar?\n1-Soma\n2-Subtracao\n3-Multiplicacao\n4-Divisao\n:" << endl;
        cin >> opcao;
    };

    cout << "Enviando matrizes para a FPGA!\n" << "Realizando operacao de "<< operacao[opcao-1] << endl;
    return 0;
}