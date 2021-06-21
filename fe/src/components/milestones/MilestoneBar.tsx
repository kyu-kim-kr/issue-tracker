import styled from 'styled-components';
import { MilestoneBarProps } from 'types/issueType';

const MilestoneBar = ({
  openedIssueCount,
  closedIssueCount,
}: MilestoneBarProps) => {
  const percent =
    (openedIssueCount / (openedIssueCount + closedIssueCount)) * 100;
  return (
    <StyledMilestoneBar>
      <DefaultBar />
      <ProgressBar percent={percent} />
    </StyledMilestoneBar>
  );
};

export default MilestoneBar;

const StyledMilestoneBar = styled.div`
  position: relative;
`;

const DefaultBar = styled.div`
  width: 100%;
  height: 0.5rem;
  border-radius: ${({ theme }) => theme.border.radius.S};
  background-color: ${({ theme }) => theme.color.grayscale.inputBG};
`;

const ProgressBar = styled.div<{ percent: number }>`
  position: absolute;
  top: 0;
  left: 0;
  width: ${({ percent }) => `${percent}%`};
  border-radius: ${({ theme }) => theme.border.radius.S};
  background-color: ${({ theme }) => theme.color.blue};
  z-index: 99;
  height: 0.5rem;
`;