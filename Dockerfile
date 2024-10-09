# Start from a core stack version
FROM jupyter/scipy-notebook:latest
RUN pip install --quiet --no-cache-dir 'Faker==30.1.0' && \
    pip install 'psycopg2-binary' && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"