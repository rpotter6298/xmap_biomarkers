dataset = "GLA02"
controls = c("Anti-human IgG", "EBNA1", "Bare-bead","His6ABP")
for (file in list.files(file.path("scripts", "backend"))){
  print(file)
  source(file.path("scripts", "backend", file))
}


### Pipeline
import(dataset)
stage_1(I01_Import, "P01_Preprocessed")
stage_2(P01_Preprocessed, "P02_Merged")
stage_3(P02_Merged, "P03_Transformed")




export_excel(P03_Transformed)
pp_dflist_wrapper(X01_bg_purge, pp_box_plot_multi)
pp_dflist_wrapper(P03_Transformed, pp_multipca)
pp_heatmap(P03_Transformed$Set_3, "compstat")
lim = limma_subset(P03_Transformed$Set_3)
pp_heatmap(lim)
str(data)