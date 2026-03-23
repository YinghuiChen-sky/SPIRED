<h1 align="center">SPIRED</h1>
<p align="center">An end-to-end framework for the prediction of protein structure and fitness from single sequence</p>

![SPIRED](figures/SPIRED_Model_Architect.png)

## Download

1. Download **SPIRED** codes from github

```bash
git clone https://github.com/YinghuiChen-sky/SPIRED.git
cd SPIRED-main
```

2. Download the SPIRED / SPIRED-Fitness / SPIRED-Stab [model parameters](https://doi.org/10.5281/zenodo.12560925) and place them in the `./model` folder.
```
mv SPIRED.pth SPIRED-Fitness.pth SPIRED-Stab.pth ./model
```

3. Download ESM-3B, ESM2-650M and ESMIF checkpoints, and move checkpoints to `./model` dir.
```
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm2_t36_3B_UR50D.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/regression/esm2_t36_3B_UR50D-contact-regression.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm2_t33_650M_UR50D.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/regression/esm1b_t33_650M_UR50S-contact-regression.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm1v_t33_650M_UR90S_1.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm1v_t33_650M_UR90S_2.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm1v_t33_650M_UR90S_3.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm1v_t33_650M_UR90S_4.pt
wget -c https://dl.fbaipublicfiles.com/fair-esm/models/esm1v_t33_650M_UR90S_5.pt
mv esm*.pt ./model
```

## Install software on Linux (Conda)
```
conda create -n spired python=3.11
conda activate spired
pip install torch==2.2.0 --index-url https://download.pytorch.org/whl/cu118
pip install torch-spline-conv torch_scatter torch_sparse torch_cluster -f https://data.pyg.org/whl/torch-2.2.0+cu118.html
pip install torch_geometric==2.2.0
pip install fair-esm 
conda install numpy pandas h5py einops biopython click numba scipy scikit-learn tqdm  tensorboard  -c conda-forge
conda config --add channels https://levinthal:paradox@conda.graylab.jhu.edu
conda install pyrosetta=2023.26
```
## Usage

- The shell scripts support the following arguments:
  `-i` input FASTA file, `-o` output folder, `-m` model directory (default: `./model`), `-d` device (default: `cpu`, e.g. `cuda:0`).

```bash
# run SPIRED 
bash run_spired.sh -i example_spired/test.fasta -m ./model -o example_spired -d cuda:0

# run SPIRED-Fitness 
bash run_spired_fitness.sh -i example_fitness/test.fasta -m ./model -o example_fitness -d cuda:0

# run SPIRED-Stab
bash run_spired_stab.sh -i example_stab/test.fasta -m ./model -o example_stab -d cuda:0
```

## Reference

- Yinghui Chen, Yunxin Xu, Di Liu, Yaoguang Xing & Haipeng Gong. An end-to-end framework for the prediction of protein structure and fitness from single sequence. Nature Communications, 15(1):7400, 2024. DOI:[10.1038/s41467-024-51776-x](https://doi.org/10.1038/s41467-024-51776-x)
- Tianyu Mi, Nan Xiao and Haipeng Gong. GDFold2: A fast and parallelizable protein folding environment with freely defined objective functions. Protein Science, 34(2):e70041, 2025.  DOI:[10.1002/pro.70041](https://doi.org/10.1002/pro.70041)

## Link
- [SPIRED-Fitness Server](https://structpred.life.tsinghua.edu.cn/server_spired_fitness.html)
- [SPIRED-Stab Server](https://structpred.life.tsinghua.edu.cn/server_spired_stab.html)
- [Original SPIRED-Fitness Github](https://github.com/Gonglab-THU/SPIRED-Fitness)