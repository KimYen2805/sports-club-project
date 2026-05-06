import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.xml.XMLConstants;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.Schema;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

import org.w3c.dom.Document;

/**
 * Combined Java pipeline for the Sports Club project.
 *
 * <p>This version keeps the ERD-corrected Maven layout and integrates M3's
 * transformation assets into the Java project.
 *
 * <p>Default paths:
 * <ul>
 *   <li>XML: src/main/resources/data/SportsClub.xml</li>
 *   <li>XSD: src/main/resources/data/SportsClub.xsd</li>
 *   <li>XSL: src/main/resources/xslt/xml/ss7_calendar.xsl</li>
 *   <li>Output: outputs/xml/ss7_main_output.xml</li>
 * </ul>
 */
public class Main {

    private static final String DEFAULT_XML = "src/main/resources/data/SportsClub.xml";
    private static final String DEFAULT_XSD = "src/main/resources/data/SportsClub.xsd";
    private static final String DEFAULT_XSL = "src/main/resources/xslt/xml/ss7_calendar.xsl";
    private static final String DEFAULT_OUTPUT = "outputs/xml/ss7_main_output.xml";

    public static void main(String[] args) {
        try {
            PipelineConfig config = parseArguments(args);

            System.out.println("Resolved XML path: " + config.xmlFile);
            System.out.println("Resolved XSD path: " + config.xsdFile);
            System.out.println("Resolved XSL path: " + config.xslFile);
            System.out.println("Resolved output path: " + config.outputFile);
            System.out.println("Use Saxon: " + config.useSaxon);
            System.out.println();

            checkFileExists(config.xmlFile, "XML");
            checkFileExists(config.xsdFile, "XSD");
            checkFileExists(config.xslFile, "XSL");

            Document xmlDocument = parseXml(config.xmlFile);
            System.out.println("XML parsed successfully.");
            System.out.println("Root element: " + xmlDocument.getDocumentElement().getNodeName());

            validateXmlAgainstXsd(config.xmlFile, config.xsdFile);
            System.out.println("XML validation successful. The file is valid against the XSD schema.");

            applyXslt(xmlDocument, config.xslFile, config.outputFile, config.useSaxon);
            System.out.println("XSLT transformation completed successfully.");
            System.out.println("Output written to: " + config.outputFile);

        } catch (IllegalArgumentException error) {
            System.err.println(error.getMessage());
            printUsage();
            System.exit(1);
        } catch (Exception error) {
            System.err.println("Pipeline failed: " + error.getMessage());
            error.printStackTrace();
            System.exit(2);
        }
    }

    private static PipelineConfig parseArguments(String[] args) {
        PipelineConfig config = new PipelineConfig();
        config.xmlFile = DEFAULT_XML;
        config.xsdFile = DEFAULT_XSD;
        config.xslFile = DEFAULT_XSL;
        config.outputFile = DEFAULT_OUTPUT;
        config.useSaxon = false;

        if (args.length == 0) {
            return config;
        }

        if (args.length == 2 || args.length == 3) {
            config.xslFile = args[0];
            config.outputFile = args[1];
            if (args.length == 3) {
                requireSaxonFlag(args[2]);
                config.useSaxon = true;
            }
            return config;
        }

        if (args.length == 4 || args.length == 5) {
            config.xmlFile = args[0];
            config.xsdFile = args[1];
            config.xslFile = args[2];
            config.outputFile = args[3];
            if (args.length == 5) {
                requireSaxonFlag(args[4]);
                config.useSaxon = true;
            }
            return config;
        }

        throw new IllegalArgumentException("Invalid number of arguments.");
    }

    private static void requireSaxonFlag(String value) {
        if (!"--use-saxon".equalsIgnoreCase(value)) {
            throw new IllegalArgumentException("Unknown flag: " + value + ". Only --use-saxon is supported.");
        }
    }

    private static void printUsage() {
        System.out.println("Usage options:");
        System.out.println();
        System.out.println("1) Use all default project paths (runs M3 SS7 by default):");
        System.out.println("   mvn compile exec:java");
        System.out.println();
        System.out.println("2) Use default XML/XSD but provide your own XSL and output paths:");
        System.out.println("   mvn compile exec:java -Dexec.args=\"src/main/resources/xslt/xml/ss8_roster.xsl outputs/xml/ss8_from_java.xml\"");
        System.out.println();
        System.out.println("3) Provide XML, XSD, XSL, and output paths explicitly:");
        System.out.println("   mvn compile exec:java -Dexec.args=\"src/main/resources/data/SportsClub.xml src/main/resources/data/SportsClub.xsd src/main/resources/xslt/json/ss9_bookings.xsl outputs/json/ss9_from_java.json\"");
        System.out.println();
        System.out.println("4) Add --use-saxon as the last argument if Saxon is on the classpath.");
    }

    private static void checkFileExists(String filePath, String label) {
        Path path = Paths.get(filePath);
        if (!Files.exists(path)) {
            throw new IllegalArgumentException(label + " file not found: " + filePath);
        }
        if (!Files.isRegularFile(path)) {
            throw new IllegalArgumentException(label + " path is not a file: " + filePath);
        }
    }

    private static Document parseXml(String xmlFile) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true);
        DocumentBuilder builder = factory.newDocumentBuilder();
        return builder.parse(new File(xmlFile));
    }

    private static void validateXmlAgainstXsd(String xmlFile, String xsdFile) throws Exception {
        SchemaFactory schemaFactory = SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Schema schema = schemaFactory.newSchema(new File(xsdFile));
        Validator validator = schema.newValidator();
        validator.validate(new StreamSource(new File(xmlFile)));
    }

    private static void applyXslt(Document xmlDocument, String xslFile, String outputFile, boolean useSaxon) throws Exception {
        Path outputPath = Paths.get(outputFile);
        if (outputPath.getParent() != null) {
            Files.createDirectories(outputPath.getParent());
        }

        TransformerFactory transformerFactory = createTransformerFactory(useSaxon);
        Transformer transformer = transformerFactory.newTransformer(new StreamSource(new File(xslFile)));
        transformer.setOutputProperty(OutputKeys.INDENT, "yes");
        transformer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        transformer.transform(new DOMSource(xmlDocument), new StreamResult(new File(outputFile)));
    }

    private static TransformerFactory createTransformerFactory(boolean useSaxon) {
        if (!useSaxon) {
            return TransformerFactory.newInstance();
        }
        try {
            return (TransformerFactory) Class.forName("net.sf.saxon.TransformerFactoryImpl")
                    .getDeclaredConstructor()
                    .newInstance();
        } catch (Exception error) {
            throw new IllegalArgumentException("Saxon was requested but could not be loaded. " +
                    "Make sure the Saxon JAR is on the classpath.", error);
        }
    }

    private static class PipelineConfig {
        private String xmlFile;
        private String xsdFile;
        private String xslFile;
        private String outputFile;
        private boolean useSaxon;
    }
}
