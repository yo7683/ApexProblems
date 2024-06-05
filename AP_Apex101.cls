/*************************************************************
 * @author : th.kim
 * @date : 2024-05-28
 * @description : Apex Problems - Apex 101
 * @target : 
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-05-28      th.kim         Initial Version
**************************************************************/
public with sharing class AP_Apex101 {

    /**
     * @author th.kim
     * @description age의 값이 13보다 크거나 같고 19보다 작거나 같은지 체크
     * @param age 주어진 Integer 숫자
     *
     * @return true || false
     */
    public Boolean isTeenager(Integer age) {
        if (age >= 13 && age <= 19) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * @author th.kim
     * @description a와 b의 값 차이를 절대값으로 구하기
     * @param a 주어진 Integer 데이터 a
     * @param b 주어진 Integer 데이터 b
     *
     * @return a와 b의 차이 절대값
     */
    public Integer diff(Integer a, Integer b) {
        // 절대값으로 계산
        Integer intReturn = Math.abs(a - b);
        return intReturn;
    }

    /**
     * @author th.kim
     * @description a + b의 값이 c와 같은지 체크
     * @param a 주어진 Integer 데이터 a
     * @param b 주어진 Integer 데이터 b
     * @param c 주어진 Integer 데이터 c
     *
     * @return true || false
     */
    public Boolean sumEquals(Integer a, Integer b, Integer c) {
        return a + b == c;
    }

    /**
     * @author th.kim
     * @description 숫자 a, b, c의 값이 오름차순인지 체크
     * @param a 주어진 Integer 데이터 a
     * @param b 주어진 Integer 데이터 b
     * @param c 주어진 Integer 데이터 c
     *
     * @return true || false
     */
    public Boolean ascendingOrder(Integer a, Integer b, Integer c) {
        return a <= b && b <= c;
    }

    /**
     * @author th.kim
     * @description 모음(a, e, i, o 또는 u)로 시작하는 문자열에 'an' 추가하고 아닌 문자열은 'a' 추가
     * @param word 주어진 String 데이터
     *
     * @return 'a ' + word || 'an ' + word
     */
    public String aOrAn(String word) {
        // 첫 문자 소문자로 GET
        String strFirst = word.substring(0, 1).toLowerCase();
        // 모음 기준으로 문자열 생성
        return (strFirst == 'a' || strFirst == 'e' || strFirst == 'i' || strFirst == 'o' || strFirst == 'u') ? 'an ' + word : 'a ' + word;
    }

    /**
     * @author th.kim
     * @description 주어진 3개의 숫자 중 가장 큰 수 반환
     * @param num1 주어진 Integer 데이터
     * @param num2 주어진 Integer 데이터
     * @param num3 주어진 Integer 데이터
     *
     * @return 가장 큰 수
     */
    public static Integer findLargest(Integer num1, Integer num2, Integer num3) {
        if (num1 > num2 && num1 > num3) {
            // num1이 가장 클 경우
            return num1;
        } else if (num2 > num1 && num2 > num3) {
            // num2이 가장 클 경우
            return num2;
        } else if (num3 > num1 && num3 > num2) {
            // num3이 가장 클 경우
            return num3;
        } else {
            // 모두 같은 값일 경우
            return 0;
        }
    }

    /**
     * @author th.kim
     * @description 지정된 퍼센트의 tip 값 계산
     * @param total 주어진 총 값 데이터
     * @param percent 주어진 퍼센트 데이터
     *
     * @return 계산된 tip 값
     */
    public Decimal computeTip(Decimal total, Integer percent) {
        return (total * percent) / 100;
    }

    /**
     * @author th.kim
     * @description 3개 중 두개 이상 true이면 true 반환
     * @param passedExam 주어진 Boolean 값
     * @param passedAssignments 주어진 Boolean 값
     * @param passedProject 주어진 Boolean 값
     *
     * @return 2개 이상 true일 시 true || false
     */
    public Boolean isPassed(Boolean passedExam, Boolean passedAssignments, Boolean passedProject) {
        if (passedExam) {
            if (passedAssignments || passedProject) return true;
        } else if (passedAssignments) {
            if (passedProject) return true;
        }
        return false;
    }

    /**
     * @author th.kim
     * @description 0으로 끝나면 true
     * @param num 주어진 Integer 값
     *
     * @return 0으로 끌날 시 true || false
     */
    public Boolean isEndWithZero(Integer num) {
        if (num == 0) {
            return true;
        } else {
            return Math.mod(num, 10) == 0;
        }
    }

    /**
     * @author th.kim
     * @description 3개의 정수가 주어질 때 2개 의 합이 1개의 정수가 될 때, 합계인 정수 반환
     * @param a 주어진 정수 값
     * @param b 주어진 정수 값
     * @param c 주어진 정수 값
     *
     * @return 합계인 정수 문자열
     */
    public String whichTwo(Integer a, Integer b, Integer c) {
        if (a + b == c) {
            // 합계 값이 c일 때
            return 'c';
        } else if (a + c == b) {
            // 합계 값이 b일 때
            return 'b';
        } else if (b + c == a) {
            // 합계 값이 a일 때
            return 'a';
        } else {
            // 합이 맞지 않을 때
            return '';
        }
    }

    /**
     * @author th.kim
     * @description 정수가 짝수일 때 'even', 홀수일 때 'odd' 반환
     * @param num 정수 값
     *
     * @return 'even' || 'odd'
     */
    public String evenOrOdd(Integer num) {
        return Math.mod(num, 2) == 0 ? 'even' : 'odd';
    }

    /**
     * @author th.kim
     * @description player1, player2 가위바위보 player1이 승리 시 1, player2가 승리 시 2, 무승부 시 0
     * @param player1 가위바위보 String 값
     * @param player2 가위바위보 String 값
     *
     * @return player1이 승리 시 1, player2가 승리 시 2, 무승부 시 0
     */
    public Integer rockPaperScissors(String player1, String player2) {
        if (player1 == 'rock') {
            if (player2 == 'paper') {
                // player2 승
                return 2;
            } else if (player2 == 'scissors') {
                // player1 승
                return 1;
            }
        } else if (player1 == 'scissors') {
            if (player2 == 'rock') {
                // player2 승
                return 2;
            } else if (player2 == 'paper') {
                // player1 승
                return 1;
            }
        } else {
            if (player2 == 'rock') {
                // player1 승
                return 1;
            } else if (player2 == 'scissors') {
                // player2 승
                return 2;
            }
        }
        // 무승부
        return 0;
    }

    /**
     * @author th.kim
     * @description 연령대 구하기
     * @param n 나이 Integer 값
     *
     * @return 연령대 문자열 || null
     */
    public String ageGroup(Integer n) {
        if (n >= 0 && n < 2) {
            return 'Infant';
        } else if (n >= 2 && n < 15) {
            return 'Child';
        } else if (n >= 15 && n < 22) {
            return 'Youth';
        } else if (n >= 15) {
            return 'Adult';
        } else {
            return 'error';
        }
    }

    /**
     * @author th.kim
     * @description 동반 식물인지 체크
     * @param plant1 식물 String 값 1
     * @param plant2 식물 String 값 2
     *
     * @return true || false
     */
    public Boolean companionPlants(String plant1, String plant2) {
        if (plant1 == 'lettuce') {
            if (plant2 == 'cucumbers' || plant2 == 'onions') return true;
        } else if (plant1 == 'onions') {
            if (plant2 == 'lettuce' || plant2 == 'carrots' || plant2 == 'tomatoes') return true;
        } else if (plant1 == 'cucumbers' && plant2 == 'lettuce') {
            return true;
        } else if (plant1 == 'carrots' && plant2 == 'onions') {
            return true;
        } else if (plant1 == 'tomatoes' && plant2 == 'onions') {
            return true;
        }
        return false;
    }

    /**
     * @author th.kim
     * @description 윤년 구하기
     * @param year 주어진 Integer 연도 값
     *
     * @return true || false
     */
    public Boolean isLeapYear(Integer year) {
        if (Math.mod(year, 4) == 0) {
            if (Math.mod(year, 100) == 0) {
                if (Math.mod(year, 400) == 0) return true;
            } else {
                return true;
            }
        }
        return false;
    }

    /**
     * @author th.kim
     * @description 소수 구하기
     * @param num 주어진 Integer 값
     *
     * @return true || false
     */
    private static Boolean isPrime(Integer num) {
        if (num <= 1) {
            return false; // 1 이하의 수는 소수가 아님
        }
        if (num <= 3) {
            return true; // 2와 3은 소수임
        }
        if (Math.mod(num, 2) == 0 || Math.mod(num, 3) == 0) {
            return false; // 2 또는 3으로 나누어 떨어지면 소수가 아님
        }
        Integer i = 5; // 5부터 시작
        while (i * i <= num) {
            if (Math.mod(num, i) == 0 || Math.mod(num, i + 2) == 0) {
                return false; // 6k ± 1 형태의 수로 나누어 떨어지면 소수가 아님
            }
            i += 6; // 6k ± 1 형태의 수만 확인
        }
        return true; // 모든 경우에 나누어 떨어지지 않으면 소수임
    }


    /**
     * @author th.kim
     * @description 1부터 n 값의 합계 구하기
     * @param n 주어진 정수 값
     *
     * @return 1부터 n의 합계
     */
    public Integer sumToN(Integer n) {
        Integer sum = 0;
        for (Integer i = 1; i <= n; i++) {
            sum += i;
        }
        return sum;
    }

    /**
     * @author th.kim
     * @description Full name 구하기
     * @param firstName First name String 값
     * @param lastName Last name String 값
     *
     * @return Full name
     */
    public String fullName(String firstName, String lastName) {
        return firstName + ' ' + lastName;
    }

    /**
     * @author th.kim
     * @description firstName, lastName 둘 다 존재하는 경우 Full name을 반환, 둘 중에 하나만 존재 시 해당 name 반환, 둘 다 존재하지 않을 시 '' 반환
     * @param firstName First name String 값
     * @param lastName Last name String 값
     *
     * @return (lastName + ', ' + firstName) || lastName || firstName || ''
     */
    public String formatName(String firstName, String lastName) {
        if (String.isNotBlank(firstName) && String.isNotBlank(lastName)) {
            return lastName + ', ' + firstName;
        } else if (String.isNotBlank(lastName)) {
            return lastName;
        } else if (String.isNotBlank(firstName)) {
            return firstName;
        } else {
            return '';
        }
    }

    /**
     * @author th.kim
     * @description Email에서 Name 추출
     * @param email firstname.lastname@example.com
     *
     * @return 'FirstName LastName'
     */
    public String nameFromEmail(String email) {
        // 첫문자만 대문자로 firstName 추출
        String firstName = email.substringBefore('.').toLowerCase().capitalize();
        // 첫문자만 대문자로 lastName 추출
        String lastName = email.substringBetween('.', '@').toLowerCase().capitalize();

        // fullName 생성
        String fullName = firstName + ' ' + lastName;

        return fullName;
    }

    /**
     * @author th.kim
     * @description 시간 형식 변환
     * @param strTime String 시간 값 ex) '23:15', '08:05'
     *
     * @return 'AM', 'PM'이 포함된 시간
     */
    public String changeTimeFormat(String strTime) {
        // 시
        Integer hour = Integer.valueOf(strTime.split(':')[0]);
        // 분
        String minutes = strTime.split(':')[1];

        if (hour > 12) {
            // 오후 시간일 때
            return String.valueOf(hour - 12).leftPad(2, '0') + ':' + minutes + ' PM';
        } else if (hour == 12 || hour == 0) {
            // 12시일 때
            String period = (hour == 12) ? 'PM' : 'AM';
            return ((hour == 0) ? '12' : '12') + ':' + minutes + ' ' + period;
        } else {
            // 오전 시간일 때
            return String.valueOf(hour).leftPad(2, '0') + ':' + minutes + ' AM';
        }
    }

    /**
     * @author th.kim
     * @description 피보나치 수열 계산
     * @param n 피보나치 수열 n번째
     *
     * @return 피보나치 수열 n번째 값
     */
    public Integer fibonacci(Integer n) {
        if (n <= 2) {
            // 2번째까지는 1 반환
            return 1;
        } else {
            Integer current = 0;
            Integer last = 1;
            Integer secondLast = 1;

            for (Integer i = 3; i <= n; i++) {
                // 이전 값, 현재 값 계산
                current = last + secondLast;
                secondLast = last;
                last = current;
            }

            return current;
        }
    }

    /**
     * @author th.kim
     * @description 현재 숫자보다 큰 가장 작은 소수 찾기
     * @param num 주어진 정수 값
     *
     * @return 현재 숫자보다 큰 가장 작은 소수
     */
    public Integer nextPrime(Integer num) {
        num++; // num보다 큰 수부터 시작

        // 소수를 찾을 때까지 반복
        while (true) {
            if (isPrime(num)) {
                return num; // 소수를 찾으면 반환
            }
            num++; // 소수가 아니면 다음 수로 이동
        }
        return null;
    }

    /**
     * @author th.kim
     * @description 단어 순서 반대로 반환
     * @param sentence 단어로 완성된 문장
     *
     * @return 단어 순서 반대로된 문장
     */
    public String reverseWordsInASentence(String sentence) {
        if (sentence != null) {

            // 문장을 단어 단위로 분할하여 배열에 저장
            List<String> words = sentence.split(' ');

            // 단어 순서를 뒤집은 후 문장으로 다시 조합
            String reversedSentence = '';
            for (Integer i = words.size() - 1; i >= 0; i--) {
                reversedSentence += words[i];
                if (i != 0) {
                    // 마지막 단어 아닐 시 공백 추가
                    reversedSentence += ' ';
                }
            }
            return reversedSentence;
        } else {
            return null;
        }
    }
}