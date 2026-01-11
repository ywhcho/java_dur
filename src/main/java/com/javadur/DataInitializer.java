package com.javadur;

import com.javadur.entity.Medicine;
import com.javadur.repository.MedicineRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

@Component
public class DataInitializer implements CommandLineRunner {

    @Autowired
    private MedicineRepository medicineRepository;

    @Override
    public void run(String... args) throws Exception {
        if (medicineRepository.count() == 0) {
            initializeMedicineData();
        }
    }

    private void initializeMedicineData() {
        Medicine m1 = new Medicine();
        m1.setName("타이레놀");
        m1.setIngredient("아세트아미노펜");
        m1.setEfficacy("진통제");
        m1.setUsage("1회 1~2정을 1일 3~4회 복용합니다. 4~6시간 간격으로 복용하며, 1일 최대 8정을 초과하지 않습니다.");
        m1.setSideEffects("드물게 피부 발진, 구역, 구토 등이 나타날 수 있습니다.");
        m1.setPrecautions("음주 시 복용을 피하고, 간 질환이 있는 경우 의사와 상담하세요.");
        m1.setManufacturer("한국얀센");
        medicineRepository.save(m1);

        Medicine m2 = new Medicine();
        m2.setName("부루펜");
        m2.setIngredient("이부프로펜");
        m2.setEfficacy("진통제");
        m2.setUsage("성인 1회 200mg을 1일 3회 복용합니다. 증상에 따라 1회 400mg까지 가능합니다.");
        m2.setSideEffects("위장 장애, 소화불량, 속쓰림 등이 나타날 수 있습니다.");
        m2.setPrecautions("공복 복용을 피하고, 위궤양이 있는 경우 주의하세요.");
        m2.setManufacturer("삼일제약");
        medicineRepository.save(m2);

        Medicine m3 = new Medicine();
        m3.setName("베아제");
        m3.setIngredient("디아스타제, 판크레아틴");
        m3.setEfficacy("소화제");
        m3.setUsage("1회 1~2정을 1일 3회 식후에 복용합니다.");
        m3.setSideEffects("일반적으로 부작용이 적으나, 드물게 알레르기 반응이 나타날 수 있습니다.");
        m3.setPrecautions("급성 췌장염이 있는 경우 복용을 피하세요.");
        m3.setManufacturer("태극제약");
        medicineRepository.save(m3);

        Medicine m4 = new Medicine();
        m4.setName("게보린");
        m4.setIngredient("아세트아미노펜, 카페인");
        m4.setEfficacy("해열제");
        m4.setUsage("성인 1회 1~2정을 1일 3~4회 복용합니다.");
        m4.setSideEffects("드물게 어지러움, 불면증이 나타날 수 있습니다.");
        m4.setPrecautions("카페인 성분이 있어 취침 전 복용을 피하세요.");
        m4.setManufacturer("삼진제약");
        medicineRepository.save(m4);

        Medicine m5 = new Medicine();
        m5.setName("판피린");
        m5.setIngredient("아세트아미노펜, 클로르페니라민");
        m5.setEfficacy("감기약");
        m5.setUsage("성인 1회 1정을 1일 3회 식후 30분에 복용합니다.");
        m5.setSideEffects("졸음, 구갈, 변비 등이 나타날 수 있습니다.");
        m5.setPrecautions("운전이나 기계 조작 시 주의하세요. 졸음이 올 수 있습니다.");
        m5.setManufacturer("동아제약");
        medicineRepository.save(m5);

        Medicine m6 = new Medicine();
        m6.setName("지르텍");
        m6.setIngredient("세티리진");
        m6.setEfficacy("알레르기약");
        m6.setUsage("성인 1회 1정을 1일 1회 복용합니다.");
        m6.setSideEffects("졸음, 두통, 구갈 등이 나타날 수 있습니다.");
        m6.setPrecautions("알코올과 함께 복용하지 마세요.");
        m6.setManufacturer("유씨비코리아");
        medicineRepository.save(m6);

        Medicine m7 = new Medicine();
        m7.setName("아모잘탄");
        m7.setIngredient("암로디핀, 로사르탄");
        m7.setEfficacy("고혈압약");
        m7.setUsage("성인 1일 1회 1정을 복용합니다.");
        m7.setSideEffects("어지러움, 두통, 피로감 등이 나타날 수 있습니다.");
        m7.setPrecautions("임산부는 복용을 피하고, 정기적인 혈압 측정이 필요합니다.");
        m7.setManufacturer("한독");
        medicineRepository.save(m7);

        Medicine m8 = new Medicine();
        m8.setName("다이아벡스");
        m8.setIngredient("메트포르민");
        m8.setEfficacy("당뇨약");
        m8.setUsage("성인 1일 2~3회 식사와 함께 복용합니다.");
        m8.setSideEffects("구역, 설사, 복통 등의 위장 장애가 나타날 수 있습니다.");
        m8.setPrecautions("신장 기능이 저하된 경우 복용을 피하고, 정기적인 혈당 검사가 필요합니다.");
        m8.setManufacturer("대웅제약");
        medicineRepository.save(m8);

        System.out.println("Sample medicine data initialized successfully.");
    }
}
