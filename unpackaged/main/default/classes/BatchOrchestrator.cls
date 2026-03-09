public class BatchOrchestrator implements Queueable {

    Integer step;

    public BatchOrchestrator(Integer step) {
        this.step = step;
    }

    public void execute(QueueableContext context) {
        if (step == 1) {
            Database.executeBatch(new Batch2(), 200);
            System.enqueueJob(new BatchOrchestrator(2));
        } else if (step == 2) {
            Database.executeBatch(new Batch1(), 200);
            System.enqueueJob(new BatchOrchestrator(3));
        } else if (step == 3) {
            Database.executeBatch(new Batch3(), 200);
                        System.enqueueJob(new BatchOrchestrator(4));

        }
    }
}