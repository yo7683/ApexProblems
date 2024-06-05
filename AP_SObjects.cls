/*************************************************************
 * @author : th.kim
 * @date : 2024-05-31
 * @description : Apex Problems - SObjects
 * @target : 
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-05-31      th.kim         Initial Version
**************************************************************/
public with sharing class AP_SObjects {

    /**
     * @author th.kim
     * @description Contact의 Email과 Phone 중에 중복이 있는지 체크
     * @param c1 Contact 데이터 1
     * @param c2 Contact 데이터 2
     *
     * @return true || false
     */
    public Boolean duplicateContacts(Contact c1, Contact c2) {
        // 이메일과 전화번호가 모두 비어 있지 않은 경우 확인
        Boolean isEmailNotBlank = String.isNotBlank(c1.Email) && String.isNotBlank(c2.Email);
        Boolean isPhoneNotBlank = String.isNotBlank(c1.Phone) && String.isNotBlank(c2.Phone);

        // 이메일이나 전화번호가 중복되는지 확인
        Boolean isEmailDuplicate = isEmailNotBlank && (c1.Email == c2.Email);
        Boolean isPhoneDuplicate = isPhoneNotBlank && (c1.Phone == c2.Phone);

        // 이메일이나 전화번호가 중복되면 true 반환
        return isEmailDuplicate || isPhoneDuplicate;
    }

    /**
     * @author th.kim
     * @description AnnualRevenue 값에 따라 등급 적용
     * @param a AnnualRevenue을 데이터를 가지고 있는 Account 데이터
     */
    public void setAccountRating(Account a) {
        if (a.AnnualRevenue <= 100000) {
            a.Rating = 'Cold';
        } else if (a.AnnualRevenue > 100000 && a.AnnualRevenue <= 500000) {
            a.Rating = 'Warm';
        } else {
            a.Rating = 'Hot';
        }
    }

    /**
     * @author th.kim
     * @description 오늘이 생일인지 체크
     * @param c Birthdate 필드가 포함된 Contact
     *
     * @return true || false
     */
    public Boolean isBirthday(Contact c) {
        return c.Birthdate.month() == Date.today().month() && c.Birthdate.day() == Date.today().day();
    }

    /**
     * @author th.kim
     * @description
     * @param a Industry, AnnualRevenue 필드가 포함되어 있는 Account 데이터
     *
     * @return true || false
     */
    public Boolean isKeyAccount(Account a) {
        Integer threshold;

        switch on a.Industry {
            when 'Retail' {
                threshold = 2000000;
            }
            when 'Technology' {
                threshold = 800000;
            }
            when 'Banking' {
                threshold = 600000;
            }
            when else {
                threshold = 500000;
            }
        }

        return a.AnnualRevenue >= threshold;
    }

    /**
     * @author th.kim
     * @description 조건에 만족할 시 에스컬레이션
     * @param c Case 데이터
     */
    public void escalateIfMeetsCriteria(Case c) {
        if ((c.Type == 'Mechanical' || c.Type == 'Electrical') && c.Reason == 'Breakdown' && c.Status == 'In Progress') c.IsEscalated = true;
    }

    /**
     * @author th.kim
     * @description 같은 부모인지 체크
     * @param c Contact 데이터
     * @param opp Opportunity 데이터
     *
     * @return true || false
     */
    public Boolean sameParent(Contact c, Opportunity opp) {
        return String.isNotBlank(c.AccountId) && String.isNotBlank(opp.AccountId) && c.AccountId == opp.AccountId;
    }

    /**
     * @author th.kim
     * @description 계정이 주어질 때 Contact과 Opportunity의 계정이 주어진 계정인지 체크
     * @param acc Account 데이터
     * @param con Contact 데이터
     * @param opp Opportunity 데이터
     *
     * @return true || false
     */
    public Boolean sameParent(Account acc, Contact con, Opportunity opp) {
        // null 체크
        if (String.isBlank(acc.Id) || String.isBlank(con.AccountId) || String.isBlank(opp.AccountId)) {
            return false;
        }

        return (con.AccountId == opp.AccountId) && (con.AccountId == acc.Id);
    }

    /**
     * @author th.kim
     * @description Contact과 Opportunity의 AccountId 주어진 Account의 Id 값으로 저장
     * @param acc 주어진 데이터
     * @param con 주어진 데이터
     * @param opp 주어진 데이터
     */
    public void setParent(Account acc, Contact con, Opportunity opp) {
        if (acc != null && String.isNotBlank(acc.Id)) {
            con.AccountId = acc.Id;
            opp.AccountId = acc.Id;
        }
    }

    /**
     * @author th.kim
     * @description 두 Case 모두 동일한 연락처를 조회하는 경우에만 먼저 생성된 사례를 나중에 생성된 사례의 상위로 설정
     * @param c1 Case 데이터
     * @param c2 Case 데이터
     */
    public void linkParent(Case c1, Case c2) {
        if (String.isNotBlank(c1.ContactId) && String.isNotBlank(c2.ContactId) && c1.ContactId == c2.ContactId) {
            // c1과 c2의 ContactId가 같을 때
            if (c1.CreatedDate > c2.CreatedDate) {
                // c2가 먼저 생성된 데이터일 때
                c1.ParentId = c2.Id;
            } else if (c2.CreatedDate > c1.CreatedDate) {
                // c1이 먼저 생성된 데이터일 때
                c2.ParentId = c1.Id;
            }
        }
    }
}