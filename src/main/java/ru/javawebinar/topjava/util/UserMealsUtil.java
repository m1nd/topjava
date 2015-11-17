package ru.javawebinar.topjava.util;

import ru.javawebinar.topjava.model.UserMeal;
import ru.javawebinar.topjava.model.UserMealWithExceed;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.Month;
import java.util.*;
import java.util.stream.Collectors;

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
        getFilteredMealsWithExceeded(mealList, LocalTime.of(7, 0), LocalTime.of(12, 0), 2000);
//        .toLocalDate();
//        .toLocalTime();
    }

    public static List<UserMealWithExceed> getFilteredMealsWithExceeded(List<UserMeal> mealList, LocalTime startTime, LocalTime endTime, int caloriesPerDay) {

        List<UserMealWithExceed> resultList = new ArrayList<>();

        Map<LocalDate, List<UserMeal>> mealListGrouped = mealList
                .stream()
                .collect(Collectors.groupingBy(ml -> ml.getDateTime().toLocalDate()));

        mealListGrouped.forEach((k, v) -> v
                .stream()
                .filter(lt -> TimeUtil.isBetween(lt.getDateTime().toLocalTime(), startTime, endTime))
                .forEach(item -> {
                            int sum = v
                                    .stream()
                                    .mapToInt(list -> list.getCalories())
                                    .sum();
                            resultList.add(new UserMealWithExceed(item.getDateTime(), item.getDescription(), item.getCalories(), sum > caloriesPerDay ? true : false));
                        }
                ));

        return resultList;
    }
}
