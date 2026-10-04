import inet.queueing.source.ActivePacketSource;
import inet.queueing.queue.DropTailQueue;
import inet.queueing.server.PacketServer;
import inet.queueing.sink.PassivePacketSink;

network Task1MM1LInet
{
    parameters:
        double lambda = default(2);

        double mu = default(5);

        int L = default(5);


    submodules:



        queue: DropTailQueue {
            parameters:
                packetCapacity = parent.L - 1;
                @display("p=300,150");
        }

        source: ActivePacketSource {
            parameters:
                productionInterval = exponential(1s / parent.lambda);
                packetLength = 1B;
                @display("p=100,150");

        }




        server: PacketServer {
            parameters:
                processingTime = exponential(1s / parent.mu);
                @display("p=500,150");

        }






        sink: PassivePacketSink {
            parameters:

                @display("p=700,150");

        }

    connections:
        source.out --> queue.in;

        queue.out --> server.in;

        server.out --> sink.in;
}