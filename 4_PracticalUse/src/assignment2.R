library(ggplot2)
library(dplyr)
library(stringr)
library(psych)

#csv 파일을 불러옵니다!
csv_data <- read.csv('4_PracticalUse/src/NationalRecreationalForestStandardData.csv'
                     , fileEncoding = "euc-kr", stringsAsFactors = FALSE, na.strings = NA)

#'forest' 데이터 프레임을 만듭니다!
forest <- as.data.frame(csv_data)

# 1. 결측치가 존재하는 변수를 확인하여 결측치를 해당 변수의 평균값으로 보정하시오.

colSums(is.na(forest)) ##결측치가 존재하는 변수를 확인

##결측치를 해당 변수의 평균값으로 보정
forest$수용인원수 <- ifelse(is.na(forest$수용인원수),
                    mean(forest$수용인원수, na.rm=T), forest$수용인원수)
forest$위도 <- ifelse(is.na(forest$위도), mean(forest$위도, na.rm=T), forest$위도)
forest$경도 <- ifelse(is.na(forest$경도), mean(forest$경도, na.rm=T), forest$경도)
colSums(is.na(forest)) ##결측치 대체 확인

# 2. 행정구역별 숙박이 가능한 휴양림의 수와 수용인원수의 합계를 구하여, 가장 많은 휴양림을 보유한 시도 5곳을 출력하시오.
forest %>%
  #숙박 가능한 휴양림 필터링
  filter(숙박가능여부=="Y") %>%  
  #시도별로 그룹핑
  group_by(시도명) %>% 
  # 변수 'n'에 시도별 숙박 가능한 휴양림 수+수용 인원 수 합계 저장
  summarise(n=n(),
            sum=sum(수용인원수)) %>%
  #summarise(n=수용인원수+n()) %>%
  # 시도별 휴양림 수 '내림차순' 정렬
  arrange(desc(n)) %>%
  # 가장 많은 휴양림 보유한 시도 5곳 추출!
  head(5)
  

# 3. 휴양림면적당 수용 인원수를 계산하여 '밀집도' 변수를 추가하고, 가장 밀집도가 낮은 3곳과 가장 밀집도가 높은 3곳의 이름,
# 시도명, 밀집도, 전화번호를 하나의 테이블로 출력하고, 이때 높은 지역은 'HD'로 낮은 지역은 'LD' 표기를 추가하시오. (단, 수용인원수가 0으로 표기된 지역은 제외)

## '휴양림 명적당 수용 인원수' density(밀집도) 변수 추가
forest <- forest %>%
            mutate(density=수용인원수/휴양림면적)

forest %>%
  # 수용인원수 0인 곳 제외
  filter(수용인원수!=0)%>% 
  #dclass 변수에 밀집도가 평균보다 높으면 'HD', 같으면 'MD', 낮으면 'LD' 값을 저장
  mutate(dclass=ifelse(density>mean(density), "HD",
                       ifelse(density==mean(density),"MD", "LD")))%>% 
  #밀집도 기준 내림차순 정렬
  arrange(desc(density)) %>% 
  #휴양림명, 시도명, 밀집도, 전화번호, 밀집도 수준 표기값 추출
  select(휴양림명, 시도명, density, 휴양림전화번호, dclass)%>%
  #밀집도 가장 높은 곳 3곳, 낮은 곳 3곳 출력
  headTail(3,3)

