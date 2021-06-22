import styled from 'styled-components';

const Input = ({
  onChange,
  label,
}: {
  onChange: (e: React.ChangeEvent<HTMLInputElement>) => void;
  label: string;
}) => {
  return (
    <StyledInput>
      <label>{label}</label>
      <input onChange={onChange} />
    </StyledInput>
  );
};

export default Input;

const StyledInput = styled.div`
  width: 100%;
  background-color: ${({ theme }) => theme.color.grayscale.line};
  display: flex;

  label {
    width: 5rem;
    height: 2.5rem;
    color: ${({ theme }) => theme.color.grayscale.label};
  }
`;
