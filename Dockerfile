# Usar uma imagem base antiga do Ubuntu que suporte PHP 5.3
FROM ubuntu:14.04

# Instalar o Apache e PHP 5.3
RUN apt-get update && \
    apt-get install -y software-properties-common && \
    add-apt-repository ppa:sergey-dryabzhinsky/php53 && \
    apt-get update && \
    apt-get install -y php53-common php53-cli apache2 libapache2-mod-php53 && \
    apt-get clean

# Habilitar o mod_rewrite do Apache
RUN a2enmod rewrite

# Copiar os arquivos do projeto para o diretório do Apache
COPY . /var/www/html

# Definir permissões para os arquivos do Apache
RUN chown -R www-data:www-data /var/www/html

# Expor a porta 80 para o Apache
EXPOSE 80

# Iniciar o Apache no foreground
CMD ["apachectl", "-D", "FOREGROUND"]
