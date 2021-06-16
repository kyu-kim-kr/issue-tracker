import styled from 'styled-components';
import { MilestonesItemLeftProps } from 'types/issueType';
import { ReactComponent as MilestoneSvg } from 'icons/milestoneBlue.svg';
import { ReactComponent as CalendarSvg } from 'icons/calendar.svg';
const MilestonesItemLeft = ({
  title,
  description,
  dueDate,
}: MilestonesItemLeftProps) => {
  return (
    <StyledMilestonesItemLeft>
      <div>
        <MilestonsIcon />
        <MilestonsItemTitle>{title}</MilestonsItemTitle>
        <DueDate>
          <DueDateIcon />
          {dueDate}
        </DueDate>
      </div>
      <div>
          {description}
      </div>
    </StyledMilestonesItemLeft>
  );
};

export default MilestonesItemLeft;

const StyledMilestonesItemLeft = styled.div`
  ${({ theme }) => theme.style.flexColum}
`;

const MilestonsItemTitle = styled.span`
 margin: 0  0.5rem;
  font-weight: ${({ theme }) => theme.fontWeight.bold};
`;
const MilestonsIcon = styled(MilestoneSvg)`

`;

const DueDateIcon = styled(CalendarSvg)``;
const DueDate = styled.span`
  color: ${({ theme }) => theme.color.grayscale.line};
`;
