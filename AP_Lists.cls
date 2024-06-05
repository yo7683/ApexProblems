/*************************************************************
 * @author : th.kim
 * @date : 2024-06-04
 * @description : Apex Problems - Lists
 * @target : 
==============================================================
 * Ver          Date            Author          Modification
 * 1.0          2024-06-04      th.kim          Initial Version
**************************************************************/
public with sharing class AP_Lists {

    /**
     * @author th.kim
     * @description Name String 리스트 오름차순 정렬
     * @param accountNames Name String 리스트
     *
     * @return 오름차순 정렬된 String 리스트
     */
    public List<String> getNamesInAscOrder(List<String> accountNames) {
        if(accountNames != null) accountNames.sort();
        return accountNames;
    }

    /**
     * @author th.kim
     * @description 정수 리스트의 합계
     * @param numbers 정수 리스트
     *
     * @return 합계
     */
    public static Integer arraySum(List<Integer> numbers) {
        Integer intSum = 0;
        for (Integer i : numbers) {
            intSum += i;
        }
        return intSum;
    }

    public Integer findTargetCount(List<Integer> nums, Integer target) {
        return 0;
    }
}