df2 <- data.frame(
  中華民國=c(36.5,92.6),
  韓國=c(28.2,73.5),
  新加坡=c(36.0,90.4),
  日本=c(48.6,90.3),
  美國=c(53.9,81.2),
  type=c("15-24歲","25-29歲")
)
df2 |> #轉換dataset
  tidyr::pivot_longer(cols = 中華民國:美國 , names_to="country", values_to ="value") |>
  dplyr::arrange(country)-> #以國家排序
  df22
df22["h"]=c(1,1,2,2,3,3,4,4,5,5)

ggplot(data=df22)+
  geom_line(mapping=aes(x=value,y=country,group=country),color="gray",size=1)+
  geom_point(mapping=aes(x=value,y=h,colour =type),size=3)+
  labs(
    title="2020 年度我國與主要國家青年勞動力參與率",
    subtitle = "統計各國青少年和青年的勞動參與率,%",
    caption = "Source: https://www.mol.gov.tw/",
    alt = "000"
  )+
  theme_minimal()+
  theme(
    plot.title = element_text(
      size = 15,
      hjust=0.5,
      
    ),
    plot.subtitle = element_text(
      hjust=0.5),
    plot.caption = element_text(
      hjust=0,
      vjust=1
    ),
    axis.title=element_blank(),
    axis.line.y = element_line(size=0.5),
    axis.text.y=element_text(size = 10),
    legend.text = element_text(size = 10),
    legend.title = element_blank(),
    plot.margin = margin(2, 2, 2, 1, "cm"))
