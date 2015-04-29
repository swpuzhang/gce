--
-- Copyright (c) 2009-2015 Nous Xiong (348944179 at qq dot com)
--
-- Distributed under the Boost Software License, Version 1.0. (See accompanying
-- file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)
--
-- See https://github.com/nousxiong/gce for latest version.
--

local gce = require('gce')
local libgce = require('libgce')
local libasio = require('libasio')
local asio = {}

local tcpopt_adl = nil
local sslopt_adl = nil
if gce.packer == gce.pkr_adata then
  tcpopt_adl = require('tcp_option_adl')
  sslopt_adl = require('ssl_option_adl')
end

-- enum and constant def
asio.sigint = libasio.sigint
asio.sigterm = libasio.sigterm

asio.sslv2 = libasio.sslv2
asio.sslv2_client = libasio.sslv2_client
asio.sslv2_server = libasio.sslv2_server
asio.sslv3 = libasio.sslv3
asio.sslv3_client = libasio.sslv3_client
asio.sslv3_server = libasio.sslv3_server
asio.tlsv1 = libasio.tlsv1
asio.tlsv1_client = libasio.tlsv1_client
asio.tlsv1_server = libasio.tlsv1_server
asio.sslv23 = libasio.sslv23
asio.sslv23_client = libasio.sslv23_client
asio.sslv23_server = libasio.sslv23_server
asio.tlsv11 = libasio.tlsv11
asio.tlsv11_client = libasio.tlsv11_client
asio.tlsv11_server = libasio.tlsv11_server
asio.tlsv12 = libasio.tlsv12
asio.tlsv12_client = libasio.tlsv12_client
asio.tlsv12_server = libasio.tlsv12_server

asio.asn1 = libasio.asn1
asio.pem = libasio.pem

asio.for_reading = libasio.for_reading
asio.for_writing = libasio.for_writing

asio.client = libasio.client
asio.server = libasio.server


function asio.timer()
  return libasio.make_system_timer(libgce.self)
end

function asio.signal(sig1, sig2, sig3)
  return libasio.make_signal(libgce.self, sig1, sig2, sig3)
end

function asio.tcp_option()
  return libasio.make_tcpopt()
end

function asio.ssl_option()
  return libasio.make_sslopt()
end

function asio.tcp_acceptor(opt)
  return libasio.make_tcp_acceptor(libgce.self, opt)
end

function asio.tcp_socket(msg)
  return libasio.make_tcp_socket(libgce.self, msg)
end

function asio.ssl_context(method, opt, pwdcb)
  return libasio.make_ssl_context(method, opt, pwdcb)
end

function asio.ssl_stream(cfg, opt)
  -- cfg is ssl_context or message
  local is_ssl_ctx = cfg:gcety() ~= gce.ty_message
  return libasio.make_ssl_stream(libgce.self, is_ssl_ctx, cfg, opt)
end

asio.as_timeout = gce.atom('as_timeout')
asio.as_signal = gce.atom('as_signal')
asio.as_accept = gce.atom('as_accept')
asio.as_conn = gce.atom('as_conn')
asio.as_handshake = gce.atom('as_handshake')
asio.as_shutdown = gce.atom('as_shutdown')
asio.as_recv = gce.atom('as_recv')
asio.as_recv_some = gce.atom('as_recv_some')
asio.as_send = gce.atom('as_send')
asio.as_send_some = gce.atom('as_send_some')

function asio.async_read(skt, length, ty)
  ty = ty or asio.as_recv
  local m = gce.message(ty)
  skt:async_read(length, m)
end

function asio.async_write(skt, ch, ty)
  ty = ty or asio.as_send
  local m = gce.message(ty, ch)
  skt:async_write(m)
end

return asio