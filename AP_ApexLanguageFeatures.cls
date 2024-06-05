/*************************************************************
 * @author : th.kim
 * @date : 2024-05-24
 * @description : Apex Problems - Apex Language Features
 * @target : 
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-05-24      th.kim         Initial Version
**************************************************************/
public with sharing class AP_ApexLanguageFeatures {

    /**
     * @author th.kim
     * @description SObject의 개체가 Account인지 체크하는 메서드
     * @param record SObject 레코드
     *
     * @return Acount일 시 true, 아닐 시 false
     */
    public Boolean isTypeAccount(SObject record) {
        return record instanceof Account;
    }

    /**
     * @author th.kim
     * @description fifteenDigit의 데이터가 15자리의 Id 값이면 18자리의 Id 값으로 리턴, 아닐 시 '-1' 리턴
     * @param fifteenDigit 15자리 Id 값
     *
     * @return 18자리 Id 값 || '-1'
     */
    public String convert15to18DigitId(String fifteenDigit) {
        if (String.isNotBlank(fifteenDigit) && fifteenDigit.length() == 15) {
            return (Id) fifteenDigit;
        } else {
            return '-1';
        }
    }

    /**
     * @author th.kim
     * @description a와 b를 나눈 값의 정수만 반환, 예외 시 Error message 반환
     * @param a Integer 데이터
     * @param b Integer 데이터
     *
     * @return 정수 데이터 || Error message
     */
    public String divide(Integer a, Integer b) {
        try {
            return String.valueOf(a / b);
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    /**
     * @author th.kim
     * @description accounts가 Null이라면 IllegalArgumentException, Account 리스트에 BillingCity가 없을 때 AccountException, 둘 다 아닐 시 accounts 리턴
     * @param accounts Account List
     *
     * @return accounts || Error message
     */
    public List<Account> checkAccounts(List<Account> accounts) {
        if (accounts != null && !accounts.isEmpty()) {
            for (Account objAcc : accounts) {
                if (String.isBlank(objAcc.BillingCity)) throw new AccountException('Invalid BillingCity');
            }
        } else {
            throw new IllegalArgumentException('accounts should not be null');
        }
        return accounts;
    }

    /**
     * @author th.kim
     * @description Accout 리스트의 첫번째 데이터의 BillingCity 대문자로 변환
     * @param accounts Account 리스트
     *
     * @return 첫번째 리스트의 BillingCity 대문자 값 || null
     */
    public String getAccountBillingCityWithSafeNavigation(List<Account> accounts) {
        for (Account objAcc : accounts) {
            if (objAcc.BillingCity != null) {
                return objAcc.BillingCity.toUpperCase();
            } else {
                return null;
            }
        }
        return null;
    }

    /**
     * @author th.kim
     * @description Account에 있는 field 동적으로 순서대로 불러오기
     * @param acc Account 데이터
     * @param fields Field API 명
     *
     * @return 데이터 있을 시 Account의 필드 데이터 값 || null
     */
    public List<String> getFieldsValue(Account acc, List<String> fields) {
        List<String> listReturn = new List<String>();
        for (String str : fields) {
            if (acc.get(str) != null) {
                listReturn.add(String.valueOf(acc.get(str)));
            } else {
                listReturn.add(null);
            }
        }
        return listReturn;
    }

    /**
     * @author th.kim
     * @description Account 리스트 데이터 JSON 타입으로 변환
     * @param accounts Account 리스트
     *
     * @return JSON 타입으로 변환된 Account 리스트
     */
    public String getAccountsInJSONFormat(List<Account> accounts) {
        return JSON.serialize(accounts);
    }

    /**
     * @author th.kim
     * @description 여러 개체 SObject 리스트에 담기
     * @param accounts Account 리스트
     * @param contacts Contact 리스트
     *
     * @return Account, Contact이 담긴 SObject 리스트
     */
    public List<SObject> getListOfsObject(List<Account> accounts, List<Contact> contacts) {
        List<SObject> listReturn = new List<SObject>();
        if (accounts != null && !accounts.isEmpty()) for (Account objAcc : accounts) listReturn.add(objAcc);
        if (contacts != null && !contacts.isEmpty()) for (Contact objContact : contacts) listReturn.add(objContact);
        return listReturn;
    }

    /**
     * @author th.kim
     * @description User 정보 맵 반환하기
     * @return User Map
     */
    public Map<String, String> getContextUserInformation() {
        return new Map<String, String>{
                'EmailId' => UserInfo.getUserEmail(),
                'ProfileId' => UserInfo.getProfileId(),
                'Type' => UserInfo.getUserType(),
                'UserName' => UserInfo.getUserName()
        };
    }

    /**
     * @author th.kim
     * @description Trigger Validation
     * @param opportunities Before Insert Opportunity
     */
    public void validateInsert(List<Opportunity> opportunities) {
        for (Opportunity objNew : opportunities) {
            if (objNew.StageName == 'Closed Won') {
                if (String.isBlank(objNew.Description)) objNew.addError('Description should not be empty for Closed Won opportunity.');
            }
        }
    }

    /**
     * @author th.kim
     * @description Account JSON 데이터 Account 리스트 형식으로 변환
     * @param inputJSON Account 리스트 JSON 타입
     *
     * @return Account 리스트 || null
     */
    public List<Account> getAccountsFromJSONString(String inputJSON) {
        return String.isNotBlank(inputJSON) ? (List<Account>) JSON.deserialize((inputJSON), List<Account>.class) : null;
    }

    /**
     * @author th.kim
     * @description Account의 AnnualRevenue 필드 기준으로 정렬
     * @param accounts Account 리스트
     *
     * @return null 아닐 시 정렬된 Account 리스트 || null
     */
    public List<Account> getAccounts(List<Account> accounts) {
        List<DynamicSortUtil> listSorter = new List<DynamicSortUtil>();
        if (accounts != null) {
            for (Account acc : accounts) {
                listSorter.add(new DynamicSortUtil(acc, 'AnnualRevenue', true));
            }
            listSorter.sort();
            List<Account> listAcc = new List<Account>();
            for (DynamicSortUtil sorter : listSorter) {
                listAcc.add((Account) sorter.objSObject);
            }
            return listAcc;
        } else {
            return null;
        }
    }

    /**
     * @author th.kim
     * @description Custom Account Exception
     */
    public class AccountException extends Exception {
    }
}