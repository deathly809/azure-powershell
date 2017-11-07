// 
// Copyright (c) Microsoft and contributors.  All rights reserved.
// 
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//   http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// 
// See the License for the specific language governing permissions and
// limitations under the License.
// 

// Warning: This code was generated by a tool.
// 
// Changes to this file may cause incorrect behavior and will be lost if the
// code is regenerated.

using AutoMapper;
using Microsoft.Azure.Commands.ResourceManager.Common.Tags;
using Microsoft.Rest.Azure;
using Microsoft.Azure.Commands.Network.Models;
using Microsoft.Azure.Management.Network;
using Microsoft.Azure.Management.Network.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Management.Automation;
using CNM = Microsoft.Azure.Commands.Network.Models;

namespace Microsoft.Azure.Commands.Network.Automation
{
    [Cmdlet(VerbsCommon.Get, "AzureRmRouteTable"), OutputType(typeof(PSRouteTable))]
    public partial class GetAzureRmRouteTable : NetworkBaseCmdlet
    {
        [Parameter(
            Mandatory = true,
            HelpMessage = "The resource group name of route table.",
            ParameterSetName = "Expand",
            ValueFromPipelineByPropertyName = true)]
        [Parameter(
            Mandatory = false,
            HelpMessage = "The resource group name of route table.",
            ParameterSetName = "NoExpand",
            ValueFromPipelineByPropertyName = true)]
        [ValidateNotNullOrEmpty]
        public string ResourceGroupName { get; set; }

        [Alias("ResourceName")]
        [Parameter(
            Mandatory = true,
            HelpMessage = "The name of route table.",
            ParameterSetName = "Expand",
            ValueFromPipelineByPropertyName = true)]
        [Parameter(
            Mandatory = false,
            HelpMessage = "The name of route table.",
            ParameterSetName = "NoExpand",
            ValueFromPipelineByPropertyName = true)]
        [ValidateNotNullOrEmpty]
        public string Name { get; set; }

        [Parameter(
            Mandatory = true,
            ParameterSetName = "Expand",
            ValueFromPipelineByPropertyName = true)]
        [ValidateNotNullOrEmpty]
        public string ExpandResource { get; set; }

        public override void Execute()
        {
            base.Execute();

            if(!string.IsNullOrEmpty(this.Name))
            {
                var vRouteTable = this.NetworkClient.NetworkManagementClient.RouteTables.Get(ResourceGroupName, Name, ExpandResource);
                var vRouteTableModel = Mapper.Map<CNM.PSRouteTable>(vRouteTable);
                vRouteTableModel.ResourceGroupName = this.ResourceGroupName;
                vRouteTableModel.Tag = TagsConversionHelper.CreateTagHashtable(vRouteTable.Tags);
                WriteObject(vRouteTableModel, true);
            }
            else
            {
                IPage<RouteTable> vRouteTablePage;
                if(!string.IsNullOrEmpty(this.ResourceGroupName))
                {
                    vRouteTablePage = this.NetworkClient.NetworkManagementClient.RouteTables.List(this.ResourceGroupName);
                }
                else
                {
                    vRouteTablePage = this.NetworkClient.NetworkManagementClient.RouteTables.ListAll();
                }

                var vRouteTableList = ListNextLink<RouteTable>.GetAllResourcesByPollingNextLink(vRouteTablePage,
                    this.NetworkClient.NetworkManagementClient.RouteTables.ListNext);
                List<PSRouteTable> psRouteTableList = new List<PSRouteTable>();
                foreach (var vRouteTable in vRouteTableList)
                {
                    var vRouteTableModel = Mapper.Map<CNM.PSRouteTable>(vRouteTable);
                    vRouteTableModel.ResourceGroupName = NetworkBaseCmdlet.GetResourceGroup(vRouteTable.Id);
                    vRouteTableModel.Tag = TagsConversionHelper.CreateTagHashtable(vRouteTable.Tags);
                    psRouteTableList.Add(vRouteTableModel);
                }
                WriteObject(psRouteTableList);
            }
        }
    }
}
