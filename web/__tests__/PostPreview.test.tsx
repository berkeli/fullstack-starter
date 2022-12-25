import { render, screen } from "@testing-library/react";
import "@testing-library/jest-dom";
import PostPreview from "../components/PostPreview";

describe("PostPreview", () => {
  it("should render correctly", () => {
    const { container } = render(<PostPreview post={{ title: "test", content: "test" }} />);
    expect(container).toMatchSnapshot();
  });
});
