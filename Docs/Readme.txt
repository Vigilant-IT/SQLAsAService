HP WAP GATEWAY ReadMe File.
Author: Wil Taylor and Steve Hosking from Vigilant.IT


CONTENTS OF THIS FILE
---------------------

* Introduction
* Requirements
* Installation
* Troubleshooting
* Change log

INTRODUCTION
------------
This is some basic documentation on how to install this package. For more detail on how to build the source code please see the build docs.




REQUIREMENTS
------------
Before this package can be installed the following is required:

* Windows 2012 R2/2012
* IIS enabled with the following features:
  - Application development (.NET 3.5 and 4 enabled)
  - Support for ASP.NET 
  - Security\ Windows Authentication 
* IIS Web site configured:
  - New website created for the web site. Recommended name HPGW.
  - SSL certificate assigned to site which is trusted by clients.
  - Web site configured to only accept HTTPS connections.
  - Configure website to only accept windows authentication (all other authentication methods disabled).
* MS SQL Server 2012 Standard+
  - Database engine
  - Administration tools.
* Service accounts and groups:
  - HPGW service account to run HPGW service with with the following rights:
    - SA database rights to all SQL servers in the environment.
    - Ability to interact with VMM to read information.
    - Ability to interact with WAP to create, remove and view plans.
    - WinRM access to all systems it interactes with
    - Full admin rights to SQL virtual machines.

Installation
------------
To install this package once the above requirements are met you need to do the following:

1) Identify Environment
  Identify the environment that this needs to be installed into. This can be done by reading the Environments.psd1 file in the root directory
  of the package.

  If environment already exists make note of its name (case sensative) so it can be used later on in the document.

  If the environment doesn't exist copy an existing environment and replace the values with the values for the new environment.

  Make sure the environment file is provided to vigilant.it so it can be added to future versions of the package.


2) Database Setup
  If there is already a database on the system you can skip this step.

  WARNING: IF YOU RUN THE FOLLOWING STEP ON A SYSTEM WITH A HPGW DATABASE ALREADY INSTALLED IT WILL DROP IT! ONLY DO THIS FOR NEW INSTALLS.

  To create a new database from powershell run the following command from the unzipped package:

  .\install.ps1 -Database -Environment TheEnvironMentName
 
  This will create the database.

 3) Installation
  To install the webservice, HPGateway and RIT sim run the following command from powershell in the root directory of this package:

  .\install.ps1 -All -Environment TheEnvironMentName

  Note: this won't install the database.

  If you only want to install an individual component like only the web service or only ritsim you can use their respective switch instead.

4) Post install activities
  After you have completed the installation complete the following tasks:

  * Change the service account for the HP GW service to be the service account. You will need to restart the service for this to take affect.
  * Run through all acceptance testing.


Troubleshooting
---------------

Future troubleshooting steps on installation to go here.




Change Log
----------
Version 2.1HF2:
* Added fix to clsFileSystem.AgeOutSubFolders to fix stackoverflow bug and allow recursive folder delete.
* Added fix to Web service to add extra checking on invalid charecters to reject any found to prevent them being passed to HPGateway service.

Version 2.1HF1:
* Added configuration for both Test and Dev environments.
* Added hotfix support to package builder.

Version 2.1:

* First version of the service to use new package system.
* Web service now enforces Windows Authentication for access.
