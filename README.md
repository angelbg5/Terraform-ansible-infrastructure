# Terraform-ansible-infrastructure

Este proyecto despliega una infraestructura utilizando **Terraform** y configura un servidor **Apache** en una de las máquinas provisionadas con **Ansible**. El objetivo es mostrar cómo automatizar el aprovisionamiento de servidores y su configuración de manera controlada.

## Esquema de la Infraestructura

![Image](https://github.com/user-attachments/assets/11f6e6fa-cbd3-43ed-ae3b-1867be14197e)

En el esquema, se puede observar que en Azure se ha provisionado una máquina virtual que incluye una red, una IP pública, una interfaz de red y un disco. Además, se ha configurado un NSG para permitir el tráfico SSH y HTTP. También se ha creado un  Service Principal para permitir que, desde nuestra máquina Ubuntu, podamos gestionar la creación de todos estos recursos mediante Terraform. Por último, se ha instalado Ansible en la máquina Ubuntu para instalar y configurar automáticamente el servidor Apache.

## ¿Qué es Terraform?

**Terraform** es una herramienta de infraestructura como código (IaC) que permite definir, desplegar y gestionar la infraestructura de manera automática mediante archivos de configuración. Terraform es completamente independiente del proveedor de la nube, lo que significa que puedes usarla para gestionar recursos en diferentes proveedores como AWS, Azure, Google Cloud, entre otros.



Con Terraform, puedes definir toda la infraestructura que necesitas (servidores, redes, bases de datos, etc.) en un archivo de configuración que luego puedes aplicar para crear y gestionar esos recursos de manera repetible y predecible. Terraform también soporta la gestión de la infraestructura de manera declarativa, es decir, defines el estado deseado y Terraform se encarga de hacer que la infraestructura llegue a ese estado.

### Características clave de Terraform:
- **Gestión de infraestructura en múltiples proveedores**: Puedes gestionar infraestructuras en AWS, Azure, Google Cloud, etc.
- **Declarativo**: Define el estado final deseado y Terraform gestiona el ciclo de vida de los recursos.
- **Versionamiento de la infraestructura**: Al estar basado en archivos de configuración, puedes versionar tu infraestructura como lo harías con el código.
- **Automatización**: Permite automatizar la creación, modificación y destrucción de recursos.

## ¿Qué es Ansible?

**Ansible** es una herramienta de automatización y configuración de sistemas. Permite gestionar la configuración de servidores de forma sencilla y sin necesidad de agentes en las máquinas a gestionar. Ansible usa un lenguaje de programación simple basado en YAML, lo que hace que sea fácil de aprender y utilizar, incluso para personas sin experiencia en programación.

Ansible se utiliza comúnmente para realizar tareas como la instalación de software, la configuración de servicios (como servidores web o bases de datos) y la gestión de la infraestructura de manera automatizada.

### Características clave de Ansible:
- **Automatización de configuraciones**: Puedes gestionar las configuraciones de tus servidores de manera automática y coherente.
- **Sin agentes**: Ansible no necesita instalar agentes en las máquinas que va a gestionar, solo requiere SSH (o WinRM en sistemas Windows).
- **Basado en YAML**: El lenguaje usado para describir las configuraciones es simple y fácil de leer.
- **Escalabilidad**: Puedes gestionar desde una sola máquina hasta miles de servidores con facilidad.

## ¿Por qué usar Terraform y Ansible juntos?

Terraform y Ansible se complementan muy bien. Terraform es excelente para aprovisionar y gestionar la infraestructura (como crear máquinas virtuales, redes, bases de datos, etc.), mientras que Ansible es ideal para gestionar la configuración de esos recursos (como instalar Apache, configurar bases de datos, etc.).

Al usar ambos, puedes asegurarte de que no solo creas la infraestructura de manera automática, sino que también configuras todos los servicios y software necesarios de forma eficiente y coherente.


------------

Este proyecto fue desarrollado por **Ángel Barahona García**. Puedes conectar conmigo a través de https://www.linkedin.com/in/angelbarahonagarc%C3%ADa
