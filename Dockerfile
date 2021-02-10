################################################################################
# Base R image https://hub.docker.com/u/rocker/
################################################################################

FROM rocker/shiny-verse:latest

################################################################################
# Authors
################################################################################

LABEL maintainer="Ashwini Kumar Sharma | a.sharma@dkfz-heidelberg.de"

################################################################################
# Install packages
################################################################################

# General updates
RUN  apt-get -y update && apt-get -y upgrade #&& apt-get -y install libbz2-dev liblzma-dev

# Shiny related packages
RUN R -e "install.packages(c('BiocManager', 'remotes', 'devtools', 'shinythemes', 'shinyjs', 'shinyWidgets', 'data.table', 'plotly', 'DT', 'waiter'), dependencies = T)"
RUN R -e "BiocManager::install(pkgs = c('Biobase'))"

# Accessory and supporting packages
RUN R -e "install.packages(c('parallel', 'gtools', 'pdist', 'enrichR', 'pheatmap', 'limSolve', 'corpcor', 'beeswarm', 'bibtex', 'nFactors', 'cowplot', 'matrixStats'), dependencies = T)"
RUN R -e "BiocManager::install(pkgs = c('fgsea'))"

# mRNA deconvolution related packages
RUN R -e "install.packages(c('ica', 'fastICA', 'NMF', 'csSAM'))"
RUN R -e "devtools::install_github('UrszulaCzerwinska/DeconICA', upgrade = 'always')"
RUN R -e "BiocManager::install(pkgs = c('DeconRNASeq'))"
RUN R -e "remotes::install_github('icbi-lab/immunedeconv')"
RUN R -e "install.packages('estimate', repos='http://r-forge.r-project.org')"

RUN R -e "install.packages(pkgs = 'http://bioconductor.org/packages/3.7/bioc/src/contrib/BiocInstaller_1.30.0.tar.gz', type = 'source')"
RUN wget http://web.cbio.uct.ac.za/~renaud/CRAN/src/contrib/CellMix_1.6.2.tar.gz && Rscript -e "install.packages(pkgs = 'CellMix_1.6.2.tar.gz', repos = NULL, type = 'source')"

# Methylation deconvolution related packages
RUN R -e "BiocManager::install(pkgs = c('EpiDISH'))"
RUN R -e "remotes::install_github(repo = 'BRL-BCM/EDec', upgrade = 'always')"
RUN R -e "remotes::install_github(repo = 'bcm-uga/medepir', upgrade = 'always')"

#RUN R -e "BiocManager::install(pkgs = c('Rhtslib', 'RnBeads'))"
#RUN R -e "BiocManager::install(pkgs = c('RnBeads'))"
#RUN R -e "remotes::install_github(repo = 'lutsik/MeDeCom',  upgrade = 'always')"

#-------------------------------------------------------------------------------
# If the docker image is created successfully, enter it and check if all packages
# are present there
#-------------------------------------------------------------------------------

# docker run --rm -it ashwinikrsharma/mrna_meth_decon:latest bash
# R

# ip = as.data.frame(installed.packages()[,c(1,3:4)])
# ip = ip[is.na(ip$Priority),1:2,drop=FALSE]

#mypacakages = c('DeconRNASeq','EpiDISH', 'csSAM', 'shinythemes', 'shinyjs', 'shinyWidgets',
#'data.table', 'plotly', 'DT', 'waiter','estimate', 'ica', 'fastICA', 'NMF', 'fgsea', 'enrichR', 'pheatmap',
#'immunedeconv', 'deconica', 'EDec', 'MeDeCom', 'medepir', 'CellMix', 'nFactors', 'cowplot')

# All available !
# ip[ip$Package %in% mypacakages,]

# All missing !
# mypacakages[! mypacakages %in% ip$Package]
