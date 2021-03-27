# ifedtree

R package `ifedtree` and replication codes for paper "**A Tree-based Federated Learning Approach for Personalized Treatment Effect Estimation from Heterogeneous Data Sources**" (available at [link](https://arxiv.org/abs/2103.06261)).

## Replication for paper

- Simulation codes are under folder code_for_paper/simulation
- Real data codes are under folder code_for_paper/eICUdata
    - The eICU Collaborative Research Database [[paper]](https://www.nature.com/articles/sdata2018178) [[website]](https://eicu-crd.mit.edu/).
    - Data are preprocessed following paper "The Search for Optimal Oxygen Saturation Targets in Critically Ill Patients: Observational Data from Large ICU Databases" [[paper]](https://doi.org/10.1016/j.chest.2019.09.015) [[github]](https://github.com/nus-mornin-lab/oxygenation_kc).

## Package installation

To install this package in R, run the following commands:

```R
install.packages("devtools")
devtools::install_github("ellenxtan/ifedtree")
```

## Usage examples

```R
library(ifedtree)
data(SimDataLst)
K <- length(SimDataLst)
covars <- grep("^X", names(SimDataLst[[1]]), value=TRUE)

# coordinating site
coord_id <- 1  
coord_test <- GenSimData(coord_id)
coord_df <- SimDataLst[[coord_id]]

# local models (causal forest from `grf` package as an example)
fit_lst <- list()
for (k in 1:K) {
    df <- SimDataLst[[k]]
    fit_lst[[k]] <- grf::causal_forest(X=as.matrix(df[, covars, with=FALSE]), Y=df$Y, W=df$Z)
}

# augmented coordinating site data
aug_df <- GenAugData(coord_id, coord_df, fit_lst, covars)

# ensemble tree
et_fit <- EnsemTree(coord_id, aug_df, "site", covars)$myfit
PlotTree(et_fit)
BestLinearProj(et_fit, coord_df, coord_id, "site", "Z", "Y", covars)

# ensemble forest
ef_fit <- EnsemForest(coord_id, aug_df, "site", covars, importance="impurity")$myfit
PlotForestImp(ef_fit)
PlotForestPred(aug_df, coord_df, coord_id, ef_fit, "site", covars, "site", "X1")
BestLinearProj(ef_fit, coord_df, coord_id, "site", "Z", "Y", covars)
```

## Cite

If you use our code, please cite
```
@misc{tan2021treebased,
      title={A Tree-based Federated Learning Approach for Personalized Treatment Effect Estimation from Heterogeneous Data Sources}, 
      author={Xiaoqing Tan and Chung-Chou H. Chang and Lu Tang},
      year={2021},
      eprint={2103.06261},
      archivePrefix={arXiv},
      primaryClass={stat.ML}
}
```