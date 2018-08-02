// ----------------------------------------------------------------------------------
//
// Copyright Microsoft Corporation
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// ----------------------------------------------------------------------------------

namespace Microsoft.Azure.Commands.Network
{
    using System;
    using System.Collections;
    using System.Collections.Generic;
    using AutoMapper;
    using CNM = Microsoft.Azure.Commands.Network.Models;
    using MNM = Microsoft.Azure.Management.Network.Models;

    public static class NetworkManagementMapperExtension
    {
        public static IMappingExpression<TSource, TDestination> ForItems<TSource, TDestination, T>(
                 this IMappingExpression<TSource, TDestination> mapper)
            where TSource : IEnumerable
            where TDestination : ICollection<T>
        {
            mapper.AfterMap((c, s) =>
            {
                if (c != null && s != null)
                {
                    foreach (var t in c)
                    {
                        s.Add(Mapper.Map<T>(t));
                    }
                }
            });

            return mapper;
        }
    }

    public class NetworkResourceManagerProfile : AutoMapper.Profile
    {
        private static IMapper _mapper = null;

        private static readonly object _lock = new object();
        
        public static IMapper Mapper
        {
            get {
                lock (_lock)
                {
                    if (_mapper == null)
                    {
                        Initialize();
                    }

                    return _mapper;
                }
            }
        }
        public override string ProfileName
        {
            get { return "NetworkResourceManagerProfile"; }
        }

        private static void Initialize() {

            var config = new MapperConfiguration(cfg => {
                cfg.AddProfile<NetworkResourceManagerProfile>();

                cfg.CreateMap<CNM.PSResourceId, MNM.SubResource>();
                cfg.CreateMap<MNM.SubResource, CNM.PSResourceId>();

                // Subnet
                // CNM to MNM
                cfg.CreateMap<CNM.PSDhcpOptions, MNM.DhcpOptions>();
                cfg.CreateMap<CNM.PSSubnet, MNM.Subnet>();
                cfg.CreateMap<CNM.PSIPConfiguration, MNM.IPConfiguration>();

                // MNM to CNM
                cfg.CreateMap<MNM.DhcpOptions, CNM.PSDhcpOptions>();
                cfg.CreateMap<MNM.Subnet, CNM.PSSubnet>();
                cfg.CreateMap<MNM.IPConfiguration, CNM.PSIPConfiguration>();

                // VirtualNetwork
                // CNM to MNM
                cfg.CreateMap<CNM.PSAddressSpace, MNM.AddressSpace>();
                cfg.CreateMap<CNM.PSVirtualNetwork, MNM.VirtualNetwork>();

                // MNM to CNM
                cfg.CreateMap<MNM.AddressSpace, CNM.PSAddressSpace>();
                cfg.CreateMap<MNM.VirtualNetwork, CNM.PSVirtualNetwork>();

                // PublicIpAddress
                // CNM to MNM
                cfg.CreateMap<CNM.PSPublicIpAddress, MNM.PublicIPAddress>();
                cfg.CreateMap<CNM.PSPublicIpAddressDnsSettings, MNM.PublicIPAddressDnsSettings>();

                // MNM to CNM
                cfg.CreateMap<MNM.PublicIPAddress, CNM.PSPublicIpAddress>();
                cfg.CreateMap<MNM.PublicIPAddressDnsSettings, CNM.PSPublicIpAddressDnsSettings>();

                // NetworkInterface
                // CNM to MNM
                cfg.CreateMap<CNM.PSNetworkInterface, MNM.NetworkInterface>();
                cfg.CreateMap<CNM.PSNetworkInterfaceDnsSettings, MNM.NetworkInterfaceDnsSettings>();
                cfg.CreateMap<CNM.PSNetworkInterfaceIPConfiguration, MNM.NetworkInterfaceIPConfiguration>();


                // MNM to CNM
                cfg.CreateMap<MNM.NetworkInterface, CNM.PSNetworkInterface>();
                cfg.CreateMap<MNM.NetworkInterfaceDnsSettings, CNM.PSNetworkInterfaceDnsSettings>();
                cfg.CreateMap<MNM.NetworkInterfaceIPConfiguration, CNM.PSNetworkInterfaceIPConfiguration>();

                // LoadBalancer
                // CNM to MNM
                cfg.CreateMap<CNM.PSLoadBalancer, MNM.LoadBalancer>();

                // MNM to CNM
                cfg.CreateMap<MNM.LoadBalancer, CNM.PSLoadBalancer>();

                // FrontendIpConfiguration
                // CNM to MNM
                cfg.CreateMap<CNM.PSFrontendIPConfiguration, MNM.FrontendIPConfiguration>();

                // MNM to CNM
                cfg.CreateMap<MNM.FrontendIPConfiguration, CNM.PSFrontendIPConfiguration>();

                // BackendAddressPool
                // CNM to MNM
                cfg.CreateMap<CNM.PSBackendAddressPool, MNM.BackendAddressPool>();

                // MNM to CNM
                cfg.CreateMap<MNM.BackendAddressPool, CNM.PSBackendAddressPool>();

                // LoadBalancingRule
                // CNM to MNM
                cfg.CreateMap<CNM.PSLoadBalancingRule, MNM.LoadBalancingRule>();

                // MNM to CNM
                cfg.CreateMap<MNM.LoadBalancingRule, CNM.PSLoadBalancingRule>();

                // Probes
                // CNM to MNM
                cfg.CreateMap<CNM.PSProbe, MNM.Probe>();

                // MNM to CNM
                cfg.CreateMap<MNM.Probe, CNM.PSProbe>();

                // InboundNatRules
                // CNM to MNM
                cfg.CreateMap<CNM.PSInboundNatRule, MNM.InboundNatRule>();

                // MNM to CNM
                cfg.CreateMap<MNM.InboundNatRule, CNM.PSInboundNatRule>();

                // InboundNatPools
                // CNM to MNM
                cfg.CreateMap<CNM.PSInboundNatPool, MNM.InboundNatPool>();

                // MNM to CNM
                cfg.CreateMap<MNM.InboundNatPool, CNM.PSInboundNatPool>();

                // NetworkSecurityGroups
                // CNM to MNM
                cfg.CreateMap<CNM.PSNetworkSecurityGroup, MNM.NetworkSecurityGroup>();

                // MNM to CNM
                cfg.CreateMap<MNM.NetworkSecurityGroup, CNM.PSNetworkSecurityGroup>();

                // NetworkSecrityRule
                // CNM to MNM
                cfg.CreateMap<CNM.PSSecurityRule, MNM.SecurityRule>();

                // MNM to CNM
                cfg.CreateMap<MNM.SecurityRule, CNM.PSSecurityRule>();

                // RouteTable
                // CNM to MNM
                cfg.CreateMap<CNM.PSRouteTable, MNM.RouteTable>();

                // MNM to CNM
                cfg.CreateMap<MNM.RouteTable, CNM.PSRouteTable>();

                // Route
                // CNM to MNM
                cfg.CreateMap<CNM.PSRoute, MNM.Route>();

                // MNM to CNM
                cfg.CreateMap<MNM.Route, CNM.PSRoute>();

                // ExpressRouteCircuit
                // CNM to MNM
                cfg.CreateMap<CNM.PSExpressRouteCircuit, MNM.ExpressRouteCircuit>();
                cfg.CreateMap<CNM.PSServiceProviderProperties, MNM.ExpressRouteCircuitServiceProviderProperties>();
                cfg.CreateMap<CNM.PSExpressRouteCircuitSku, MNM.ExpressRouteCircuitSku>();
                cfg.CreateMap<CNM.PSPeering, MNM.ExpressRouteCircuitPeering>();
                cfg.CreateMap<CNM.PSExpressRouteCircuitAuthorization, MNM.ExpressRouteCircuitAuthorization>();

                // MNM to CNM
                cfg.CreateMap<MNM.ExpressRouteCircuit, CNM.PSExpressRouteCircuit>();
                cfg.CreateMap<MNM.ExpressRouteCircuitServiceProviderProperties, CNM.PSServiceProviderProperties>();
                cfg.CreateMap<MNM.ExpressRouteCircuitSku, CNM.PSExpressRouteCircuitSku>();
                cfg.CreateMap<MNM.ExpressRouteCircuitPeering, CNM.PSPeering>();
                cfg.CreateMap<MNM.ExpressRouteCircuitAuthorization, CNM.PSExpressRouteCircuitAuthorization>();

                // ExpressRouteCircuitPeering
                // CNM to MNM
                cfg.CreateMap<CNM.PSPeering, MNM.ExpressRouteCircuitPeering>();
                cfg.CreateMap<CNM.PSPeeringConfig, MNM.ExpressRouteCircuitPeeringConfig>();

                // MNM to CNM
                cfg.CreateMap<MNM.ExpressRouteCircuitPeering, CNM.PSPeering>();
                cfg.CreateMap<MNM.ExpressRouteCircuitPeeringConfig, CNM.PSPeeringConfig>();

                // ExpressRouteServiceProvider
                // CNM to MNM
                cfg.CreateMap<CNM.PSExpressRouteServiceProvider, MNM.ExpressRouteServiceProvider>();
                cfg.CreateMap<CNM.PSExpressRouteServiceProviderBandwidthsOffered, MNM.ExpressRouteServiceProviderBandwidthsOffered>();

                // MNM to CNM
                cfg.CreateMap<MNM.ExpressRouteServiceProvider, CNM.PSExpressRouteServiceProvider>();
                cfg.CreateMap<MNM.ExpressRouteServiceProviderBandwidthsOffered, CNM.PSExpressRouteServiceProviderBandwidthsOffered>();

                // ExoressRouteCircuitAuthorization
                // CNM to MNM
                cfg.CreateMap<CNM.PSExpressRouteCircuitAuthorization, MNM.ExpressRouteCircuitAuthorization>();

                // MNM to CNM
                cfg.CreateMap<MNM.ExpressRouteCircuitAuthorization, CNM.PSExpressRouteCircuitAuthorization>();


                // Gateways
                // CNM to MNM
                cfg.CreateMap<CNM.PSVirtualNetworkGateway, MNM.VirtualNetworkGateway>();
                cfg.CreateMap<CNM.PSConnectionResetSharedKey, MNM.ConnectionResetSharedKey>();
                cfg.CreateMap<CNM.PSConnectionSharedKey, MNM.ConnectionSharedKey>();
                cfg.CreateMap<CNM.PSLocalNetworkGateway, MNM.LocalNetworkGateway>();
                cfg.CreateMap<CNM.PSVirtualNetworkGatewayConnection, MNM.VirtualNetworkGatewayConnection>();
                cfg.CreateMap<CNM.PSVirtualNetworkGatewayIpConfiguration, MNM.VirtualNetworkGatewayIPConfiguration>();
                cfg.CreateMap<CNM.PSVirtualNetworkGatewaySku, MNM.VirtualNetworkGatewaySku>();
                cfg.CreateMap<CNM.PSVpnClientConfiguration, MNM.VpnClientConfiguration>();
                cfg.CreateMap<CNM.PSVpnClientParameters, MNM.VpnClientParameters>();
                cfg.CreateMap<CNM.PSVpnClientRevokedCertificate, MNM.VpnClientRevokedCertificate>();
                cfg.CreateMap<CNM.PSVpnClientRootCertificate, MNM.VpnClientRootCertificate>();
                cfg.CreateMap<CNM.PSBgpSettings, MNM.BgpSettings>();

                // MNM to CNM
                cfg.CreateMap<MNM.VirtualNetworkGateway, CNM.PSVirtualNetworkGateway>();
                cfg.CreateMap<MNM.ConnectionResetSharedKey, CNM.PSConnectionResetSharedKey>();
                cfg.CreateMap<MNM.ConnectionSharedKey, CNM.PSConnectionSharedKey>();
                cfg.CreateMap<MNM.LocalNetworkGateway, CNM.PSLocalNetworkGateway>();
                cfg.CreateMap<MNM.VirtualNetworkGatewayConnection, CNM.PSVirtualNetworkGatewayConnection>();
                cfg.CreateMap<MNM.VirtualNetworkGatewayIPConfiguration, CNM.PSVirtualNetworkGatewayIpConfiguration>();
                cfg.CreateMap<MNM.VirtualNetworkGatewaySku, CNM.PSVirtualNetworkGatewaySku>();
                cfg.CreateMap<MNM.VpnClientConfiguration, CNM.PSVpnClientConfiguration>();
                cfg.CreateMap<MNM.VpnClientParameters, CNM.PSVpnClientParameters>();
                cfg.CreateMap<MNM.VpnClientRevokedCertificate, CNM.PSVpnClientRevokedCertificate>();
                cfg.CreateMap<MNM.VpnClientRootCertificate, CNM.PSVpnClientRootCertificate>();
                cfg.CreateMap<MNM.BgpSettings, CNM.PSBgpSettings>();

                // Application Gateways
                // CNM to MNM
                cfg.CreateMap<CNM.PSApplicationGateway, MNM.ApplicationGateway>();
                cfg.CreateMap<CNM.PSApplicationGatewaySku, MNM.ApplicationGatewaySku>();
                cfg.CreateMap<CNM.PSApplicationGatewayPathRule, MNM.ApplicationGatewayPathRule>();
                cfg.CreateMap<CNM.PSApplicationGatewayUrlPathMap, MNM.ApplicationGatewayUrlPathMap>();
                cfg.CreateMap<CNM.PSApplicationGatewayProbe, MNM.ApplicationGatewayProbe>();
                cfg.CreateMap<CNM.PSApplicationGatewayBackendAddress, MNM.ApplicationGatewayBackendAddress>();
                cfg.CreateMap<CNM.PSApplicationGatewayBackendAddressPool, MNM.ApplicationGatewayBackendAddressPool>();
                cfg.CreateMap<CNM.PSApplicationGatewayBackendHttpSettings, MNM.ApplicationGatewayBackendHttpSettings>();
                cfg.CreateMap<CNM.PSApplicationGatewayFrontendIPConfiguration, MNM.ApplicationGatewayFrontendIPConfiguration>();
                cfg.CreateMap<CNM.PSApplicationGatewayFrontendPort, MNM.ApplicationGatewayFrontendPort>();
                cfg.CreateMap<CNM.PSApplicationGatewayHttpListener, MNM.ApplicationGatewayHttpListener>();
                cfg.CreateMap<CNM.PSApplicationGatewayIPConfiguration, MNM.ApplicationGatewayIPConfiguration>();
                cfg.CreateMap<CNM.PSApplicationGatewayRequestRoutingRule, MNM.ApplicationGatewayRequestRoutingRule>();
                cfg.CreateMap<CNM.PSApplicationGatewaySslCertificate, MNM.ApplicationGatewaySslCertificate>();
                cfg.CreateMap<CNM.PSBackendAddressPool, MNM.BackendAddressPool>();

                // MNM to CNM
                cfg.CreateMap<MNM.ApplicationGateway, CNM.PSApplicationGateway>();
                cfg.CreateMap<MNM.ApplicationGatewaySku, CNM.PSApplicationGatewaySku>();
                cfg.CreateMap<MNM.ApplicationGatewayPathRule, CNM.PSApplicationGatewayPathRule>();
                cfg.CreateMap<MNM.ApplicationGatewayUrlPathMap, CNM.PSApplicationGatewayUrlPathMap>();
                cfg.CreateMap<MNM.ApplicationGatewayProbe, CNM.PSApplicationGatewayProbe>();
                cfg.CreateMap<MNM.ApplicationGatewayBackendAddress, CNM.PSApplicationGatewayBackendAddress>();
                cfg.CreateMap<MNM.ApplicationGatewayBackendAddressPool, CNM.PSApplicationGatewayBackendAddressPool>();
                cfg.CreateMap<MNM.ApplicationGatewayBackendHttpSettings, CNM.PSApplicationGatewayBackendHttpSettings>();
                cfg.CreateMap<MNM.ApplicationGatewayFrontendIPConfiguration, CNM.PSApplicationGatewayFrontendIPConfiguration>();
                cfg.CreateMap<MNM.ApplicationGatewayFrontendPort, CNM.PSApplicationGatewayFrontendPort>();
                cfg.CreateMap<MNM.ApplicationGatewayHttpListener, CNM.PSApplicationGatewayHttpListener>();
                cfg.CreateMap<MNM.ApplicationGatewayIPConfiguration, CNM.PSApplicationGatewayIPConfiguration>();
                cfg.CreateMap<MNM.ApplicationGatewayRequestRoutingRule, CNM.PSApplicationGatewayRequestRoutingRule>();
                cfg.CreateMap<MNM.ApplicationGatewaySslCertificate, CNM.PSApplicationGatewaySslCertificate>();
                cfg.CreateMap<MNM.BackendAddressPool, CNM.PSBackendAddressPool>();
            });
            _mapper = config.CreateMapper();

        }        
    }
}