import java.util.Scanner;

public class PlayFair {

	public static void fillPMat(char[][] pMat, String key) {

		int[] freq = new int[26];

		int l = key.length();

		int matRow = 0;
		int matCol = 0;

		for (int i = 0; i < l; i++) {
			if (freq[key.charAt(i) - 97] == 0) {
				if (key.charAt(i) == 'j' && freq['i' - 97] != 0) {
					continue;
				}
				if (key.charAt(i) == 'i' && freq['j' - 97] != 0) {
					continue;
				}
				freq[key.charAt(i) - 97]++;
				pMat[matRow][matCol] = key.charAt(i);
				matCol++;
				if (matCol >= 5) {
					matCol = 0;
					matRow++;
				}
			}
			
		}
		
		for (int i = 0; i < 26; i++) {
			if (freq[i] == 0) {
				if ((char) (i + 97) == 'i' && freq['j' - 97] != 0)
					continue;
				if ((char) (i + 97) == 'j' && freq['i' - 97] != 0)
					continue;
				if (matCol >= 5) {
					matCol = 0;
					matRow++;
				}
				if(matRow >= 5)
					break;
				pMat[matRow][matCol] = (char) (i + 97);
				matCol++;
			}
		}

	}
	
	public static String encrypt(String pText){
		
		StringBuilder cText = new StringBuilder();
		
		
		
		return cText;
		
	}

	public static void main(String[] args) {

		Scanner sc = new Scanner(System.in);

		char[][] pMat = new char[5][5];

		System.out.print("Enter the key in lower case: ");

		String key = sc.nextLine();

		fillPMat(pMat, key);
		
		for(int i = 0; i < 5; i++){
			for(int j = 0; j < 5; j++){
				System.out.print(pMat[i][j]+" ");
			}
			System.out.println();
		}
		
		System.out.print("Enter the plain text in lower case: ");
		
		String pText = sc.nextLine();
		
		String cText = encrypt(pText);
		
		sc.close();

	}

}
