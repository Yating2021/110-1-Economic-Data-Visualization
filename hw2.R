#讀取data
library(readr)
data_hw1 <- read_csv("unemploymentrate_education.csv")

#建一個新data取目前需要的col
newdata <- data.frame(
  year=data_hw1$Field1,
  male=data_hw1$Field2,
  female=data_hw1$Field3,
  male0=data_hw1$Field10,
  female0=data_hw1$Field11,
  male1=data_hw1$Field16,
  female1=data_hw1$Field17
)

#處理遺漏值
library(dplyr)
newdata %>%
  filter(
    female1!="-"
  ) -> 
  nonna

#轉換data型態
nonna$male1 <- as.numeric(nonna$male1)
nonna$female1 <- as.numeric(nonna$female1)
nonna$year <- as.character(nonna$year)

# 換成long的形式
nonna|> 
  tidyr::pivot_longer(
    cols=male0:female1,
    names_to = "type",
    values_to= "rate"
  ) ->
  nonna_long

#畫圖
ggplot() + 
  geom_col(
    data=nonna_long,
    mapping=aes(
      x=year,
      y=rate,
      group=factor(type,c("female0","male0","female1","male1")),
      fill=factor(type,c("female0","male0","female1","male1")),
    ),
    width=0.8, 
    position = "dodge" 
  )+
  geom_line(
    data=nonna,
    mapping=aes(
      x=c(1,2,3,4,5,6,7,8,9),
      y=female
    )
  )+
  geom_line(
    data=nonna,
    mapping=aes(
      x=c(1,2,3,4,5,6,7,8,9),
      y=male
    ),
    linetype=2
  ) +
  geom_text(
    data=nonna_long,
    mapping=aes(
      x=year,
      y=rate,
      label=rate,
      group=factor(type,c("female0","male0","female1","male1"))
    ),
    position = position_dodge(width = 1),
    size=3
  )+
  geom_text(
    mapping=aes(
      x=c(10,10),
      y=c(4,3.1),
      label=c("平均女性失業率","平均男性失業率")
    )
  )+
  scale_fill_brewer(
    name="類別",
    breaks=c("female0","male0","female1","male1"),
    labels=c("高中女性", "高中男性","大學女性","大學男性"),
    palette = "Spectral")+
  theme(
    axis.line.x = element_blank(),
    axis.ticks = element_blank(),
    axis.title = element_blank(),
    axis.text = element_text(
      size = 12
    ),
    panel.grid.major.y = element_line(
      color = "grey"
    ),
    legend.position = "top",
    legend.text = element_text(
      size = 12
    )
  )
labs(title = "2011年至2019年失業率")

