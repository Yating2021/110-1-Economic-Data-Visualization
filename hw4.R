library(readr)
data_hw4 <- read_csv("marry.csv")
ggplot()+geom_sf(
  data=mdata,
  mapping=aes(
    fill=結婚對數
  ),
  color="white",
  size=0.15,
) +colorspace::scale_fill_continuous_sequential(
  na.value="#dbd7a8",
  palette = "peach"
)+theme_void(
)+labs(
  title="2021 年度台灣各地區結婚總數",
  caption = "資料來源：內政部戶政司全球資訊網",
) ->plot
plot
