# STA 521 Project 2: Cloud Recognition

This is a data analysis project that aims to recognize and differentiate cloud pixels from those non-cloud pixels in satellite images. Given the dataset of three images, we have access to 11 variables and 345,556 observations as described in the project document. Based on the three given images, we performed a reasonable EDA and preparation process, applied several classification methods, and conducted an in-depth analysis in several directions. 

## Reproducibility 

In order to help interested researchers reproduce our paper from scratch, we provide the following files:

| File name            | Description                                                  |
| -------------------- | ------------------------------------------------------------ |
| `imagem1.txt`        | Dataset of image 1                                           |
| `imagem2.txt`        | Dataset of image 2                                           |
| `imagem3.txt`        | Dataset of image 3                                           |
| `Codes.R`            | R script file containing all reproducible codes in this paper |
| `Codes.Rmd`          | R markdown file containing all reproducible codes in this paper |
| `CVmaster.R`         | R script file containing functions `CVmaster1` and `CVmaster2` |
| `./rds/blocks_1.rds` | `Rds` file containing the blocks of cross validation for `CVmaster1` |
| `./rds/blocks_2.rds` | `Rds` file containing the blocks of cross validation for `CVmaster2` |
| `Write-up.docx`      | `docx` file containing all the write-ups                     |
| `README.md`          | The file you are reading                                     |

`imagem1.txt`, `imagem2.txt` and `imagem3.txt` are the raw datasets for this paper. Please make sure that they are placed in the working directory when you run the codes in `Codes.R` or `Codes.Rmd`. Contents in  `Codes.R` and `Codes.Rmd` are basically the same, except that the `Rmd` file looks better for the sake of exposition. Running any one of `Codes.R` or `Codes.Rmd` can produce the exactly same outputs (such as plots and numbers) as we present in our paper, and the rationale of these codes is also explained exhaustively in our paper.

 `CVmaster.R` is the R script file that specifically contains two functions `CVmaster1` and `CVmaster2` for Type-1 splitting and Type-2 splitting respectively. Since the ways of creating training/val/test sets for both functions are specially designed, and the functions' arguments do not include given datasets, we pre-save two `Rds` file `blocks_1.rds` and `blocks_2.rds` under the folder `rds` so that the two functions can be fed with the right data. In addition, before running codes in the file `CVmaster.R`, please make sure that the folder `./rds/` is placed in the working directory.

In fact, the two functions mentioned above have already been placed into the files `Codes.R` and `Codes.Rmd`, so the two files themselves are self-contained enough. If at some point an error is discovered in the three image files, the only things an interested researcher need to do are to 

- replace the original raw `txt` datasets with the correct ones;
- re-run all codes in the file `Codes.R` or `Codes.Rmd`, and
- change the corresponding output numbers and plots in `Write-up.docx`.

## Authors

- Xiaozhu Zhang, xiaozhu.zhang@duke.edu
- Xuyang Tian, xuyang.tian@duke.edu