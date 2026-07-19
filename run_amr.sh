#!/bin/bash
# ============================================================
# Genome Firewall - self-contained server pipeline
#
#   bash run_amr.sh ids.txt [n_parallel]
#
# Installs its own micromamba + AMRFinderPlus (no root needed),
# downloads FASTAs, annotates, packages the results.
# Safe to re-run: anything already done is skipped.
# ============================================================
set -u

IDS=${1:-ids.txt}
NP=${2:-$(nproc)}
ORGANISM="Escherichia"
ROOT=$(pwd)

echo "======================================"
echo " IDs      : $IDS ($(wc -l < "$IDS") genomes)"
echo " Parallel : $NP"
echo " Workdir  : $ROOT"
echo "======================================"
echo

mkdir -p fasta amr_out logs

# ------------------------------------------------------------
# 0. Bootstrap micromamba + AMRFinderPlus
# ------------------------------------------------------------
export MAMBA_ROOT_PREFIX="$ROOT/mamba"

if [ ! -x "$ROOT/bin/micromamba" ]; then
  echo "[0/3] Installing micromamba ..."
  curl -Ls https://micro.mamba.pm/api/micromamba/linux-64/latest \
    | tar -xj bin/micromamba
fi

MM="$ROOT/bin/micromamba"

if [ ! -d "$MAMBA_ROOT_PREFIX/envs/amr" ]; then
  echo "[0/3] Creating amr environment (a few minutes) ..."
  "$MM" create -y -n amr -c conda-forge -c bioconda ncbi-amrfinderplus -q
fi

if ! "$MM" run -n amr amrfinder --version > /dev/null 2>&1; then
  echo "ERROR: amrfinder is not working. See $MAMBA_ROOT_PREFIX"
  exit 1
fi

echo "      AMRFinderPlus $("$MM" run -n amr amrfinder --version 2>/dev/null)"

echo "[0/3] Updating AMR database ..."
"$MM" run -n amr amrfinder -u > logs/db_update.log 2>&1
echo

# ------------------------------------------------------------
# 1. Download FASTAs
# ------------------------------------------------------------
echo "[1/3] Downloading FASTAs ..."
T0=$(date +%s)

tr -d '\r' < "$IDS" | xargs -P "$NP" -I{} sh -c '
  f="fasta/{}.fna"
  [ -s "$f" ] && exit 0
  curl --ftp-ssl -L --fail -s --retry 3 --max-time 120 \
       "ftp://ftp.bv-brc.org/genomes/{}/{}.fna" -o "$f" || rm -f "$f"
'

echo "      downloaded: $(ls fasta 2>/dev/null | wc -l)  ($(($(date +%s) - T0))s)"
echo

# ------------------------------------------------------------
# 2. Annotate
# ------------------------------------------------------------
echo "[2/3] Running AMRFinderPlus on $NP cores ..."
T0=$(date +%s)

export MM ORGANISM

ls fasta/*.fna 2>/dev/null | xargs -P "$NP" -I{} sh -c '
  b=$(basename "{}" .fna)
  out="amr_out/$b.tsv"
  [ -s "$out" ] && exit 0
  "$MM" run -n amr amrfinder -n "{}" --organism "$ORGANISM" --plus \
      --threads 1 -o "$out" > "logs/$b.log" 2>&1 || rm -f "$out"
'

echo "      annotated: $(ls amr_out 2>/dev/null | wc -l)  ($(($(date +%s) - T0))s)"
echo

# ------------------------------------------------------------
# 3. Package
# ------------------------------------------------------------
echo "[3/3] Packaging ..."
tar czf amr_out.tar.gz amr_out
echo "      -> amr_out.tar.gz ($(du -h amr_out.tar.gz | cut -f1))"
echo
echo "Pull it back with:"
echo "  scp <user>@<server>:$ROOT/amr_out.tar.gz ."