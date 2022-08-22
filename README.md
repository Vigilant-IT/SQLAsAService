### Copyright 2022 Operations & Technology Group Pty Ltd

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# HPWAPWebService
Final Release of the HPE SQLaaS project. Operations & Technology Group Pty Ltd
As a result of the project coming to a close this is the Final version of the code

This version of the solution contains all of the logic for the Micro and Elstic Databases. as part of this the whole Allocation of resources has been rewritten to better handle the process

The following tasks are still a work in progress, (the code exists just needs to reorganised to meet the new requirements)

Delete Databases,
Delete Resource Governance objects,
Completation of the Job engine,
Completation of the Web Admin Site
Completation of the redeveloped Request IT Simulator
Validation of the provisioning of Business Critical Databases,
completation of the Installation process.

The following Things have been improved from the existing production release.

The allocation of VHDX's to ensure that the VM is not left in an inconsistance state, along with streamlined process of adding disks.
Improved handling of SQL calls to allow for expanded error messages
Improved handling of PowerShell Sessions
DNS changed from ANAME to CNAME records
Configuring the Tenant SQL Servers to meet the configurations which are required for Micro and Elastic Databases
Allocation of Resources to Resource Groups rather then Databases
WorkFlows for the provisioning of Resource Groups, SQL Tenant Servers, and Databases completed
Re-Engineered Web Service, and RitSim to handle the new workflows which were required for the Micro and Elastic Databases.
Where possible all hardcoded variables have been extracted and placed into the config file for the Windows Service
Updated the Database Schema for GW to handle the new tables.

If you need to compile and run this solution in the future you will need to manually install Gateway project using the installutil.exe application to register the Windows Service, and Publish the WAP_WebService to an IIS session. then update the config files for each of the Projects and it should work.
