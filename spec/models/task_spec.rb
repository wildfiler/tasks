require 'spec_helper'

describe Task do
  describe 'state switching' do
    describe 'to finished' do
      it 'fill finished_at with current time' do
        Timecop.freeze do
          task = create :task
          expect{
            task.finish
            task.reload
          }.to change{task.finished_at.to_i}.to(Time.now.to_i)
        end
      end
    end
  end
end