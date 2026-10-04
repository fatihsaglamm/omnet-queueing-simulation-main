import inet.queueing.source.ActivePacketSource;
import inet.queueing.queue.DropTailQueue;
import inet.queueing.server.PacketServer;
import inet.queueing.sink.PassivePacketSink;
import inet.queueing.common.PacketDemultiplexer;
import inet.queueing.common.PacketMultiplexer;

network MMcL_Inet
{
    parameters:
        double lambda = default(2);
        double mu = default(5);
        int c = default(2);
        int L = default(5);

    submodules:
        source: ActivePacketSource {
            parameters:
                productionInterval = exponential(1s / parent.lambda);
                packetLength = 1B;
                @display("p=100,200");
        }

        queue: DropTailQueue {
            parameters:
                // L is total system capacity.
                // c packets can be in service, so queue capacity is L - c.
                packetCapacity = parent.L - parent.c;
                @display("p=300,200");
        }

        demux: PacketDemultiplexer {
            parameters:
                @display("p=470,200");
        }

        server[c]: PacketServer {
            parameters:
                processingTime = exponential(1s / parent.mu);
                @display("p=650,120+80*index");
        }

        mux: PacketMultiplexer {
            parameters:
                @display("p=830,200");
        }

        sink: PassivePacketSink {
            parameters:
                @display("p=1000,200");
        }

    connections:
        source.out --> queue.in;
        queue.out --> demux.in;

        for i=0..c-1 {
            demux.out++ --> server[i].in;
            server[i].out --> mux.in++;
        }

        mux.out --> sink.in;
}