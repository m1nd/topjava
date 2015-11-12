package ru.javawebinar.topjava.util;

import ru.javawebinar.topjava.model.UserMeal;
import ru.javawebinar.topjava.model.UserMealWithExceed;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.util.*;

/**
 * GKislin
 * 31.05.2015.
 */
public class UserMealsUtil {
    public static void main(String[] args) {
        List<UserMeal> mealList = Arrays.asList(

                new UserMeal(LocalDateTime.of(2015, Month.MAY, 30,10,0), "Завтрак", 500),
                new UserMeal(LocalDateTime.of(2015, Month.MAY, 30,13,0), "Обед", 1000),
                new UserMeal(LocalDateTime.of(2015, Month.MAY, 30,20,0), "Ужин", 500),
                new UserMeal(LocalDateTime.of(2015, Month.MAY, 31,10,0), "Завтрак", 1000),
                new UserMeal(LocalDateTime.of(2015, Month.MAY, 31,13,0), "Обед", 500),
                new UserMeal(LocalDateTime.of(2015, Month.MAY, 31,20,0), "Ужин", 510)

        );
        getFilteredMealsWithExceeded(mealList, LocalTime.of(7, 0), LocalTime.of(12,0), 2000);
//        .toLocalDate();
//        .toLocalTime();
//        Time complexity = O(N)
    }

    public static List<UserMealWithExceed>  getFilteredMealsWithExceeded(List<UserMeal> mealList, LocalTime startTime, LocalTime endTime, int caloriesPerDay) {

        List<UserMealWithExceed> resultList = new ArrayList<>();
        List<Integer> passedIndexesUserMeal = new ArrayList<>();
        Map<LocalDate, Integer> exceedMap = new HashMap<>();

        Collections.sort(mealList, new Comparator<UserMeal>() {
            public int compare(UserMeal o1, UserMeal o2) {
                if (o1.getDateTime() == null || o2.getDateTime() == null)
                    return 0;
                return o1.getDateTime().compareTo(o2.getDateTime());
            }
        });

        LocalDate tempDate = mealList.get(0).getDateTime().toLocalDate();
        int caloriesCount = mealList.get(0).getCalories();
        int lastElement = mealList.size() - 1;

        for (int i = 0; i < mealList.size(); i++) {
            UserMeal tempUserMeal = mealList.get(i);
            if (i != 0) {
                if ( tempUserMeal.getDateTime().toLocalDate().isEqual(tempDate) ) {
                    caloriesCount = caloriesCount + tempUserMeal.getCalories();
                    if (i == lastElement) {
                        exceedMap.put(tempDate, caloriesCount);
                    }
                } else {
                        exceedMap.put(tempDate, caloriesCount);
                        caloriesCount = tempUserMeal.getCalories();
                        if (i == lastElement) {
                            exceedMap.put(tempUserMeal.getDateTime().toLocalDate(), caloriesCount);
                        }
                }
            }
            tempDate = tempUserMeal.getDateTime().toLocalDate();
            if ( TimeUtil.isBetween(tempUserMeal.getDateTime().toLocalTime(), startTime, endTime) ) {
                passedIndexesUserMeal.add(i);
            }
        }

        for (int i = 0; i < passedIndexesUserMeal.size(); i++) {
            int index = passedIndexesUserMeal.get(i);
            UserMeal tempUserMeal = mealList.get(index);
            Boolean exceedFlag = (exceedMap.get(tempUserMeal.getDateTime().toLocalDate()) > caloriesPerDay) ? true :  false;
            resultList.add(new UserMealWithExceed(tempUserMeal.getDateTime(), tempUserMeal.getDescription(), tempUserMeal.getCalories(), exceedFlag));
        }

        return resultList;
    }
}
